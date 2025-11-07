# paqueteR ![](reference/figures/logo.png)

**paqueteR** es un paquete desarrollado para el análisis y visualización
de datos meteorológicos de distintas estaciones.

Incluye funciones para: - Leer datos de una estación
(`leer_datos_estacion`) - Crear una tabla resumen
(`tabla_resumen_temperatura`) - Generar un gráfico mensual
(`grafico_temperatura_mensual`) - Dataset de ejemplo: `NH0437`

------------------------------------------------------------------------

## Instalación

``` r
# install.packages("remotes")
remotes::install_github("benjabalsola/paqueteR")
```

## 💡 Ejemplo de uso

A continuación se muestra un ejemplo de flujo de trabajo con el paquete:

``` r
library(paqueteR)
```

## Cargar el dataset de ejemplo incluido en el paquete

data(“NH0437”)

## Ver las primeras filas

head(NH0437)

## Calcular un resumen de temperatura

tabla_resumen_temperatura(NH0437)

## Graficar la temperatura promedio mensual

grafico_temperatura_mensual( NH0437, titulo = “Promedio mensual NH0437”
)

## **Autores**

**Benjamín Balsola** (autor principal)  
**Ramiro Coletto** (coautor)

**Universidad Austral – Programación II (2025)**
