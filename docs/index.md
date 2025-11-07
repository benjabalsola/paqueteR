# paqueteTemperatura

Analisis y graficos de datos meteorologicos de estaciones.

El paquete incluye funciones para: - descargar datos de estaciones (con
cache local), - crear una tabla resumen de temperatura por estacion, -
graficar temperatura promedio mensual por estacion.

## Instalacion

Instalar desde GitHub:

\`\`\`r \# install.packages(“remotes”)
remotes::install_github(“benjabalsola/paqueteTemperatura”)

## Ejemplo de uso

\`\`\`r library(paqueteTemperatura)

# Cargar el dataset de ejemplo incluido en el paquete

data(“NH0437”)

# Ver las primeras filas

head(NH0437)

# Calcular resumen

tabla_resumen_temperatura(NH0437)

# Graficar temperatura promedio mensual

grafico_temperatura_mensual(NH0437, titulo = “Promedio mensual NH0437”)
