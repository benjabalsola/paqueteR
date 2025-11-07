test_that("tabla_resumen_temperatura devuelve data.frame con filas", {
  data("NH0437", package = "paqueteR")
  out <- tabla_resumen_temperatura(NH0437)
  expect_s3_class(out, "data.frame")
  expect_true(nrow(out) >= 1)
})
