# Leer datos de una estacion (o metadatos) desde GitHub con cache local

Descarga (si no existe) y lee el CSV correspondiente a una estacion
meteorologica de la lista disponible, o el archivo de metadatos. Si
`ruta_archivo` ya existe, **no** vuelve a descargar: lo lee directo.

## Usage

``` r
leer_datos_estacion(id_estacion, ruta_archivo)
```

## Arguments

- id_estacion:

  Cadena con el ID a leer. Valores validos: "metadatos", "NH0472",
  "NH0910", "NH0046", "NH0098", "NH0437".

- ruta_archivo:

  Ruta local .csv donde guardar/leer el archivo (por ejemplo,
  "data-raw/NH0437.csv"). Si la carpeta no existe, se crea
  automaticamente.

## Value

Un `tibble` (data frame) con columnas id, fecha,
temperatura_abrigo_150cm.
