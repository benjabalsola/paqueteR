test_that("tabla_resumen_temperatura valida entrada y calcula columnas", {
  skip_on_cran()

  df <- NH0437
  res <- tabla_resumen_temperatura(df)

  expect_s3_class(res, "data.frame")
  expect_true(all(c("id","media","minimo","maximo","desviacion","n_observaciones") %in% names(res)))
  expect_true(all(vapply(res[c("media","minimo","maximo","desviacion")], is.numeric, logical(1))))
})

test_that("tabla_resumen_temperatura falla con objeto no data.frame", {
  expect_error(tabla_resumen_temperatura(1:5))
})

test_that("tabla_resumen_temperatura falla si faltan columnas requeridas", {
  df_mal <- data.frame(id = "X", otra = 1)
  expect_error(tabla_resumen_temperatura(df_mal), regexp = "Faltan columnas")
})
