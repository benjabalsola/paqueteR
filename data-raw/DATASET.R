# data-raw/prepare.R
# Prepara el dataset NH0437 para incluirlo dentro del paquete

devtools::load_all()  # para usar leer_datos_estacion()

# 1) Descargar y leer el archivo usando tu propia funcion
# (Si el archivo ya existe, no lo vuelve a bajar)
df <- suppressWarnings(
  leer_datos_estacion("NH0437", "data-raw/NH0437.csv")
)

# 2) Seleccionar solo las columnas necesarias
df <- df[, c("id", "fecha", "temperatura_abrigo_150cm")]

# 3) Convertir tipos de datos de forma segura
# Fecha (por si viene como texto)
if (inherits(df$fecha, "character")) {
  df$fecha <- suppressWarnings(lubridate::ymd(df$fecha))
}

# Temperatura (por si viene con coma decimal o texto)
if (!is.numeric(df$temperatura_abrigo_150cm)) {
  usa_coma <- any(grepl(",", df$temperatura_abrigo_150cm))
  df$temperatura_abrigo_150cm <- suppressWarnings(
    readr::parse_number(
      df$temperatura_abrigo_150cm,
      locale = readr::locale(decimal_mark = if (usa_coma) "," else ".")
    )
  )
}

# 4) Filtrar filas validas (sin NA)
df <- dplyr::filter(df, !is.na(fecha), !is.na(temperatura_abrigo_150cm))

# 5) Asignar el nombre del dataset final
NH0437 <- df

# 6) Guardar el dataset dentro del paquete
usethis::use_data(NH0437, overwrite = TRUE, compress = "xz")
