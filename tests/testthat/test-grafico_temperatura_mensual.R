test_that("grafico_temperatura_mensual devuelve un ggplot", {
  data("NH0437", package = "paqueteR")
  p <- grafico_temperatura_mensual(NH0437, titulo = "Test")
  expect_s3_class(p, "ggplot")
})
