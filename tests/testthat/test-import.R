context("get_competitions")

test_that("returns response succesfully", {
  response <- get_competitions()

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
  })

context("extract_season_ids")

test_that("returns character vector", {
  response <- get_competitions()
  ids <- extract_season_ids(response, "Premier League")

  expect_is(ids, "character")
  })

test_that("ids labelled by season", {
  response <- get_competitions()
  ids <- extract_season_ids(response, "Premier League")

  season_regex <- "\\d{4}\\/\\d{2}"
  id_regex <- "\\d{1,2}"

  expect_match(names(ids), season_regex)
  expect_match(ids, id_regex)
  })

