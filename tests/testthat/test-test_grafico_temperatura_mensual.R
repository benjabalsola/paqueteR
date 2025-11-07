test_that("grafico_temperatura_mensual devuelve un ggplot", {
  skip_on_cran()

  df <- NH0437
  p <- grafico_temperatura_mensual(df, titulo = "Test")
  expect_s3_class(p, "ggplot")
})

test_that("grafico_temperatura_mensual valida columnas requeridas", {
  df_mal <- data.frame(id="X", fecha=as.Date("2024-01-01"))
  expect_error(grafico_temperatura_mensual(df_mal), regexp="Faltan columnas")
})
