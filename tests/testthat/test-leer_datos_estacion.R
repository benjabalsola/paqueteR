test_that("leer_datos_estacion lee CSV local existente", {
  tmp <- tempfile(fileext = ".csv")
  df <- data.frame(
    id = c("NH0437","NH0437","NH0437"),
    fecha = as.Date("2024-01-01") + 0:2,
    temperatura_abrigo_150cm = c(20.1, 21.0, 19.8)
  )
  utils::write.csv(df, tmp, row.names = FALSE)

  out <- leer_datos_estacion("NH0437", tmp)

  expect_s3_class(out, "data.frame")
  expect_true(all(c("id","fecha","temperatura_abrigo_150cm") %in% names(out)))
  expect_equal(nrow(out), 3)
})
