#' Tabla resumen de temperatura por estacion
#'
#' Combina varios data frames (uno por estacion) y calcula estadisticas
#' descriptivas basicas de la temperatura a 150 cm de abrigo.
#' Valida que todos los argumentos sean data frames y muestra un mensaje
#' informativo al finalizar.
#'
#' @param ... Uno o mas data frames que contengan al menos las columnas
#'   `id` y `temperatura_abrigo_150cm`. Cada data frame representa una estacion.
#'
#' @return Un `tibble` con una fila por estacion y las columnas:
#'   \describe{
#'     \item{id}{Identificador de estacion.}
#'     \item{media}{Temperatura media (C).}
#'     \item{minimo}{Temperatura minima (C).}
#'     \item{maximo}{Temperatura maxima (C).}
#'     \item{desviacion}{Desviacion estandar (C).}
#'     \item{n_observaciones}{Cantidad de observaciones validas.}
#'   }
#'
#' @examples
#' \dontrun{
#' df1 <- data.frame(id=c("A","A","B"), temperatura_abrigo_150cm=c(21.5,22.1,19.8))
#' df2 <- data.frame(id=c("C","C"),     temperatura_abrigo_150cm=c(23.0,24.1))
#' tabla_resumen_temperatura(df1, df2)
#' }
#'
#' @export
#' @importFrom dplyr bind_rows group_by summarise
#' @importFrom cli cli_abort cli_inform
tabla_resumen_temperatura <- function(...) {
  args <- list(...)

  # Validación: debe haber al menos un data frame
  if (length(args) == 0) {
    cli::cli_abort("Debes pasar uno o más data frames para generar el resumen.")
  }

  # Verificación: todos deben ser data frames
  if (!all(vapply(args, is.data.frame, logical(1)))) {
    cli::cli_abort("Todos los argumentos deben ser data frames. Verifica los objetos pasados a la funcion.")
  }

  # Combinar todas las estaciones en una sola tabla
  datos_combinados <- dplyr::bind_rows(args)

  # Chequeo de columnas requeridas
  columnas_necesarias <- c("id", "temperatura_abrigo_150cm")
  faltan <- setdiff(columnas_necesarias, names(datos_combinados))
  if (length(faltan) > 0) {
    cli::cli_abort("Faltan columnas en los data frames: {paste(faltan, collapse = ', ')}.")
  }

  # Validación: la columna de temperatura debe ser numérica
  if (!is.numeric(datos_combinados$temperatura_abrigo_150cm)) {
    cli::cli_abort("La columna 'temperatura_abrigo_150cm' debe ser numérica.")
  }

  # Calcular resumen por estacion
  resumenes <- datos_combinados |>
    dplyr::group_by(id) |>
    dplyr::summarise(
      media           = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      minimo          = min(temperatura_abrigo_150cm, na.rm = TRUE),
      maximo          = max(temperatura_abrigo_150cm, na.rm = TRUE),
      desviacion      = sd(temperatura_abrigo_150cm,  na.rm = TRUE),
      n_observaciones = sum(!is.na(temperatura_abrigo_150cm)),
      .groups = "drop"
    )

  # Mensaje informativo
  cli::cli_inform("Resumen generado correctamente para {nrow(resumenes)} estación(es).")

  return(resumenes)
}
