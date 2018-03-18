context("get_textstream")

test_that("returns response succesfully", {
  response <- get_textstream(matchid = "22632")

  expect_equal(response$status_code, 200)
  expect_is(response, "response")
})

context("extract_match_details")

test_that("returns named list", {
  response <- get_textstream(matchid = "22632")
  match_details <- extract_match_details(response)

  expect_is(match_details, "list")
  expect_is(names(match_details), "character")
})

test_that("returns game specifics and events", {
  response <- get_textstream(matchid = "22632")
  match_details <- extract_match_details(response)

  expect_equal(names(match_details), c("game","events"))

})

test_that("game contains game id, attendance, date, team and score information", {
  # setup test
  response <- get_textstream(matchid = "22632")
  match_details <- extract_match_details(response)

  # setup expectations
  games <- match_details$game

  # assert
  expected_fields <- c("game_id", "gameweek","attendance","home_team","away_team","home_score","away_score","date")
  expect_equal(names(games), expected_fields)

})

test_that("events contains time and type of event + id player involved", {
  # setup test
  response <- get_textstream(matchid = "22632")
  match_details <- extract_match_details(response)

  # setup expectations
  id_regex <- "\\d{4,5}"
  events <- match_details$events
  max_length_match <- 90*60 + 10*60 # maximum length match is 90*60 seconds (regular time) + 10*60 seconds (overtime)

  # content expectations
  # events %>%
  #   walk(~expect_named(., c("time","type","player_id"))) # makes conceptually the most sense but is very slow
  # instead the calculate the frequency of each field and see if total adds up
  expected_fields <- c("time","type","player_id")
  freq_fields_list <- events %>%
    map(~names(.))
  freq_fields_table <- table(unlist(freq_fields_list))

  nr_actual_fields <- sum(freq_fields_table)
  nr_expected_fields <- length(events) * length(expected_fields)

  expect_equal(nr_actual_fields, nr_expected_fields)

  # player_id expectation
  player_ids <- events %>%
    map(~.[["player_id"]])
  player_ids <- unlist(player_ids)

  expect_match(player_ids, id_regex)

  # time of event expectation
  time <- events %>%
    map(~.[["time"]])
  time <- unlist(time)

  higher_than_min_length_match <- all(time >= 0, na.rm = TRUE)
  lower_than_max_length_match <- all(time < max_length_match, na.rm = TRUE)
  expect_true(higher_than_min_length_match & lower_than_max_length_match)

  # type of event expectation
  type <- events %>%
    map(~.[["type"]])
  type <- unlist(type)
  expect_is(type, "character") # not feasible to list all types of match events
})
