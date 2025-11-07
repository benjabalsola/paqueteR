# Tabla resumen de temperatura por estacion

Combina varios data frames (uno por estacion) y calcula estadisticas
descriptivas basicas de la temperatura a 150 cm de abrigo. Valida que
todos los argumentos sean data frames y muestra un mensaje informativo
al finalizar.

## Usage

``` r
tabla_resumen_temperatura(...)
```

## Arguments

- ...:

  Uno o mas data frames que contengan al menos las columnas `id` y
  `temperatura_abrigo_150cm`. Cada data frame representa una estacion.

## Value

Un `tibble` con una fila por estacion y las columnas:

- id:

  Identificador de estacion.

- media:

  Temperatura media (C).

- minimo:

  Temperatura minima (C).

- maximo:

  Temperatura maxima (C).

- desviacion:

  Desviacion estandar (C).

- n_observaciones:

  Cantidad de observaciones validas.

## Examples

``` r
if (FALSE) { # \dontrun{
df1 <- data.frame(id=c("A","A","B"), temperatura_abrigo_150cm=c(21.5,22.1,19.8))
df2 <- data.frame(id=c("C","C"),     temperatura_abrigo_150cm=c(23.0,24.1))
tabla_resumen_temperatura(df1, df2)
} # }
```
