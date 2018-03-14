context("get_player")

test_that("returns response succesfully", {
  response <- get_player(player_id = "10428", competition_id = "1")
  
  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_player_details")

test_that("returns named list", {
  response <- get_player(player_id = "10428", competition_id = "1")
  player_details <- extract_player_details(response)
  
  expect_is(player_details, "list")
  expect_is(names(player_details), "character")
})

test_that("returns position, birthdate, name and stats", {
  response <- get_player(player_id = "10428", competition_id = "1")
  player_details <- extract_player_details(response)
  
  not_empty <- function(field) expect_true(nchar(field) > 0)
  
  expect_named(player_details, c("position","birthdate","name","stats"))
  lapply(X = player_details[c("position","birthdate")],
         FUN = not_empty)
  lapply(X = player_details[["name"]],
         FUN = not_empty) # just check if something is returned
})

test_that("returns stats related to time played: appearances and minutes played", {
  response <- get_player(player_id = "10428", competition_id = "1")
  player_details <- extract_player_details(response)
  
  lapply(X = player_details[["stats"]][['time_played']],
         FUN = function(x) expect_is(x, "numeric"))
})