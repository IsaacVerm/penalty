context("get_player")

test_that("returns response succesfully", {
  response <- get_player(player_id = "10428", competition_id = "1")

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_player_details")

full_response <- get_player(player_id = "10428", competition_id = "1")
full_player_details <- extract_player_details(full_response)

empty_response = get_player(player_id = "94289", competition_id = "1")
empty_player_details <- extract_player_details(empty_response)

expected_column_names <- c("player_id","position","birthdate","first_name","last_name")

test_that("returns dataframe", {
  expect_is(full_player_details, "data.frame")
  expect_is(empty_player_details, "data.frame")
})

test_that("returns player_id, position, birthdate, first_name, last_name", {
  expect_named(full_player_details, expected_column_names)
})

test_that("all variables empty dataframe are NA", {
  na_by_variable <- apply(X = empty_player_details,
                          MARGIN = 1,
                          FUN = function(x) is.na(x))

  expect_true(all(na_by_variable))
})

test_that("empty response still has all column names", {
  expect_named(empty_player_details, expected_column_names)
})
