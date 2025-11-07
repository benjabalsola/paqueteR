
library(testthat)
test_that("leer_datos_estacion lee un CSV existente sin descargar", {
  skip_on_cran()

  # Crear un CSV temporal con datos válidos
  tmp <- withr::local_tempfile(fileext = ".csv")
  readr::write_csv(
    data.frame(
      id = "NH0437",
      fecha = as.Date("2024-01-01"),
      temperatura_abrigo_150cm = 20
    ),
    tmp
  )

  # Ejecutar la función
  out <- leer_datos_estacion("NH0437", tmp)

  # Expectativas
  expect_s3_class(out, "data.frame")
  expect_true(all(c("id", "fecha", "temperatura_abrigo_150cm") %in% names(out)))
})

test_that("leer_datos_estacion falla con id invalido", {
  skip_on_cran()

  tmp <- withr::local_tempfile(fileext = ".csv")
  readr::write_csv(data.frame(a = 1), tmp)

  expect_error(
    leer_datos_estacion("FOO9999", tmp),
    regexp = "ID"
  )

})
