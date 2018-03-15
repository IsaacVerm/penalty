context("get_players")

response <- get_players(season_id = "79")

test_that("returns response succesfully", {
  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_player_ids")

player_ids <- extract_player_ids(response)

test_that("returns character vector", {
  expect_is(player_ids, "character")
})

test_that("returns player id", {
  id_regex <- "\\d{4,5}"
  
  expect_match(player_ids, id_regex)
})