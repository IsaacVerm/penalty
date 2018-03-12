context("get_competitions")

test_that("returns response succesfully", {
  response <- get_competitions()

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})
