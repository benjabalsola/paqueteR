#' Leer datos de una estacion (o metadatos) desde GitHub con cache local
#'
#' Descarga (si no existe) y lee el CSV correspondiente a una estacion
#' meteorologica de la lista disponible, o el archivo de metadatos.
#' Si `ruta_archivo` ya existe, no vuelve a descargar: lo lee directo.
#'
#' @param id_estacion "metadatos", "NH0472", "NH0910", "NH0046", "NH0098", "NH0437"
#' @param ruta_archivo Ruta local .csv donde guardar/leer (p.ej. "data-raw/NH0437.csv")
#' @return Tibble con los datos leídos tal como están en el CSV
#' @export
#' @importFrom readr read_csv
#' @importFrom utils download.file
leer_datos_estacion <- function(id_estacion, ruta_archivo) {

  enlaces <- list(
    "metadatos" = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/metadatos_completos.csv",
    "NH0472"    = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
    "NH0910"    = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
    "NH0046"    = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
    "NH0098"    = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
    "NH0437"    = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv"
  )

  # Validaciones básicas
  if (!is.character(id_estacion) || length(id_estacion) != 1L || is.na(id_estacion)) {
    stop("`id_estacion` debe ser un string de longitud 1.", call. = FALSE)
  }
  if (!(id_estacion %in% names(enlaces))) {
    stop("ID invalido. Usa uno de: ", paste(names(enlaces), collapse = ", "), call. = FALSE)
  }
  if (!is.character(ruta_archivo) || length(ruta_archivo) != 1L || is.na(ruta_archivo)) {
    stop("`ruta_archivo` debe ser un string con la ruta .csv.", call. = FALSE)
  }

  url <- enlaces[[id_estacion]]

  # Descarga solo si no existe localmente
  if (!file.exists(ruta_archivo)) {
    message("Descargando '", id_estacion, "' desde GitHub...")
    dir.create(dirname(ruta_archivo), showWarnings = FALSE, recursive = TRUE)
    utils::download.file(url, destfile = ruta_archivo, quiet = TRUE, mode = "wb")
  } else {
    message("Archivo local encontrado: se leera directamente desde '", ruta_archivo, "'.")
  }

  # Lee y devuelve tal cual
  readr::read_csv(ruta_archivo, show_col_types = FALSE)
}
