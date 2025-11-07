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

test_that("tabla_resumen_temperatura falla sin argumentos", {
  expect_error(
    tabla_resumen_temperatura(),
    regexp = "Debes pasar uno o más data frames"
  )
})

test_that("tabla_resumen_temperatura falla si la temperatura no es numérica", {
  df_malo <- data.frame(
    id = c("A","B"),
    temperatura_abrigo_150cm = c("21.5","22.1"),
    stringsAsFactors = FALSE
  )
  expect_error(
    tabla_resumen_temperatura(df_malo),
    regexp = "debe ser numérica"
  )
})

test_that("tabla_resumen_temperatura combina múltiples data frames y resume", {
  df1 <- data.frame(id = c("A","A"), temperatura_abrigo_150cm = c(20, 22))
  df2 <- data.frame(id = c("B"),     temperatura_abrigo_150cm = c(18))
  res <- tabla_resumen_temperatura(df1, df2)
  expect_equal(nrow(res), 2L)
  expect_true(all(c("A","B") %in% res$id))
  expect_true(all(c("media","minimo","maximo","desviacion","n_observaciones") %in% names(res)))
})

test_that("tabla_resumen_temperatura emite mensaje informativo", {
  df <- data.frame(id = c("A","A"), temperatura_abrigo_150cm = c(20, 22))
  expect_message(
    tabla_resumen_temperatura(df),
    regexp = "Resumen generado correctamente"
  )
})
