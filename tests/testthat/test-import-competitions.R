context("get_competitions")

test_that("returns response succesfully", {
  response <- get_competitions()

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
  })

context("extract_competition_ids")

test_that("returns list", {
  response <- get_competitions()
  ids <- extract_competition_ids(response, "Premier League")

  expect_is(ids, "list")
  })

test_that("returns ids labelled by season", {
  response <- get_competitions()
  ids <- extract_competition_ids(response, "Premier League")

  id_regex <- "\\d{1,2}"
  label_regex <- "\\d{4}\\/\\d{2}"

  season_ids <- ids[["season"]]
  season_labels <- names(season_ids)

  expect_match(season_ids, id_regex)
  expect_match(season_labels, label_regex)
  })

test_that("returns competition id", {
  response <- get_competitions()
  ids <- extract_competition_ids(response, "Premier League")

  id_regex <-"\\d{1}"

  competition_id <- ids[["competition"]]

  expect_match(competition_id, id_regex)
  })

