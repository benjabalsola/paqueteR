#' Grafico mensual de temperatura por estacion
#'
#' Agrega los datos por mes (1–12) a partir de la columna `fecha` y grafica
#' la temperatura promedio mensual por `id` (estacion). Si se pasa un vector
#' de `colores`, se usa; si no, se generan colores automaticamente. **Nota**:
#' el calculo mensual agrega todas las observaciones de todos los anios juntos.
#'
#' @param datos Un data frame con al menos las columnas:
#'   `id` (estacion), `fecha` (Date o convertible) y
#'   `temperatura_abrigo_150cm` (numerica).
#' @param colores Vector opcional de colores a usar por estacion. Si su longitud
#'   es menor que la cantidad de estaciones, se recicla.
#' @param titulo Titulo del grafico.
#'
#' @return Un objeto `ggplot2::ggplot`.
#'
#' @examples
#' \dontrun{
#' # df tiene columnas: id, fecha, temperatura_abrigo_150cm
#' g <- grafico_temperatura_mensual(df, titulo = "Temp promedio por mes")
#' print(g)
#' }
#'
#' @export
#' @importFrom dplyr mutate group_by summarise
#' @importFrom lubridate month
grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {
  # ---- Validaciones minimas -------------------------------------------------
  req_cols <- c("id", "fecha", "temperatura_abrigo_150cm")
  faltan <- setdiff(req_cols, names(datos))
  if (length(faltan) > 0) {
    stop("Faltan columnas en `datos`: ", paste(faltan, collapse = ", "), call. = FALSE)
  }

  # Normalizar fecha si viene como character
  if (inherits(datos$fecha, "character")) {
    # intenta Date directo; si falla, intenta POSIX y castea a Date
    sup <- try(as.Date(datos$fecha), silent = TRUE)
    if (inherits(sup, "try-error") || anyNA(sup)) {
      sup <- as.Date(as.POSIXct(datos$fecha, tz = "UTC"))
    }
    datos$fecha <- sup
  }
  if (!inherits(datos$fecha, "Date")) {
    stop("`fecha` debe ser Date o convertible a Date.", call. = FALSE)
  }

  # ---- 1) Agregacion mensual -----------------------------------------------
  datos_mensual <- datos |>
    dplyr::mutate(mes = lubridate::month(fecha)) |>
    dplyr::group_by(id, mes) |>
    dplyr::summarise(
      promedio = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  # ---- 2) Paleta de colores -------------------------------------------------
  estaciones <- unique(datos_mensual$id)

  if (is.null(colores)) {
    # colores base de R, aleatorios; garantizamos longitud adecuada
    colores <- sample(colors(), length(estaciones))
  } else if (length(colores) < length(estaciones)) {
    colores <- rep(colores, length.out = length(estaciones))
  }
  escala <- setNames(colores, estaciones)

  # ---- 3) Grafico -----------------------------------------------------------
  g <- ggplot2::ggplot(datos_mensual, ggplot2::aes(x = mes, y = promedio)) +
    ggplot2::geom_line(ggplot2::aes(color = id)) +
    ggplot2::geom_point(ggplot2::aes(color = id)) +
    ggplot2::scale_color_manual(values = escala) +
    ggplot2::labs(
      title = titulo,
      x = "Mes",
      y = "Temperatura promedio",
      color = "Estacion"
    ) +
    ggplot2::theme_minimal(base_size = 12)

  g
}
