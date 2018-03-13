context("get_fixtures")

test_that("returns response succesfully", {
  response <- get_fixtures(competition_id = "1", season_id = "79")

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_match_ids")

test_that("returns character vector of ids", {
  response <- get_fixtures(competition_id = "1", season_id = "79")
  ids <- extract_match_ids(response)

  id_regex <- "\\d{4,5}"

  expect_is(ids, "character")
  expect_match(ids, id_regex)
})
