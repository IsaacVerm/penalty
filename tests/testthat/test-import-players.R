context("get_players")

response <- get_players(season_id)

test_that("returns response succesfully", {
  
  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_player_ids")

player_ids <- extract_player_ids(response)

test_that("returns named vector", {
  expect_is(player_ids, "character")
  expect_is(names(player_ids), "character")
})

test_that("returns player name and player id", {
  id_regex <- "\\d{4,5}"
  name_returned <- all(nchar(names(player_ids)) > 0)
  
  expect_true(name_returned)
  expect_match(player_ids, id_regex)
})