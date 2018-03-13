context("get_fixtures")

test_that("returns response succesfully", {
  response <- get_fixtures(competition_id = "1", season_id = "79")

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})
