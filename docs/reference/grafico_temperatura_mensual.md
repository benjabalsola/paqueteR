# Grafico mensual de temperatura por estacion

Agrega los datos por mes (1–12) a partir de la columna `fecha` y grafica
la temperatura promedio mensual por `id` (estacion). Si se pasa un
vector de `colores`, se usa; si no, se generan colores automaticamente.
**Nota**: el calculo mensual agrega todas las observaciones de todos los
anios juntos.

## Usage

``` r
grafico_temperatura_mensual(datos, colores = NULL, titulo = "Temperatura")
```

## Arguments

- datos:

  Un data frame con al menos las columnas: `id` (estacion), `fecha`
  (Date o convertible) y `temperatura_abrigo_150cm` (numerica).

- colores:

  Vector opcional de colores a usar por estacion. Si su longitud es
  menor que la cantidad de estaciones, se recicla.

- titulo:

  Titulo del grafico.

## Value

Un objeto
[`ggplot2::ggplot`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Examples

``` r
if (FALSE) { # \dontrun{
# df tiene columnas: id, fecha, temperatura_abrigo_150cm
g <- grafico_temperatura_mensual(df, titulo = "Temp promedio por mes")
print(g)
} # }
```
