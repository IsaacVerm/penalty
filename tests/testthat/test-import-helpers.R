# setup common to all tests

if (length(ls()) > 0) {
  rm(list = ls()) # remove objects in working directory (if any)
}

project_root <- here::here()
data_path <- paste(project_root,"data", sep = "/") # variables used by all tests

# setup_files_to_remove <- dir(path = data_path,
#                              pattern = "import*")
# if (length(setup_files_to_remove) > 0) {
#   file.remove(paste(data_path, setup_files_to_remove, sep = "/")) # remove files already saved before (if any)
# }
#
# match_ids <- c("22643","22645","22342", "22344") # e.g. 22643 has no attendance value
# responses <- match_ids %>%  map(get_textstream)
# list_match_details <- responses %>% map(extract_match_details) # get list of match_details
#
# # save_games
#
# context("save_games")
#
# save_games(list_match_details)
# load(paste(data_path, "import-df_games.RData", sep = "/")) # save and load back into memory
#
# test_that("file import-df_games.RData is saved in project_root/data", {
#   saved_files <- dir(data_path)
#
#   expect_true("import-df_games.RData" %in% saved_files)
# })
#
# test_that("df_games saved is dataframe", {
#   expect_is(df_games, 'data.frame')
# })
#
# test_that("df_games has game_id, gameweek, attendance, home_team, away_team, home_score, away_score and date columns", {
#   expect_named(df_games, c("game_id", "gameweek","attendance","home_team","away_team","home_score","away_score","date"))
# })
#
# test_that("df_games isnt't empty", {
#   expect_true(nrow(df_games) > 1) # if  you put placeholder 0 would still pass
# })
#
# # save_events
#
# context("save_events")
#
# save_events(list_match_details)
# load(paste(data_path, "import-df_events.RData", sep = "/"))
#
# test_that("file import-df_events.RData is saved in project_root/data", {
#   saved_files <- dir(data_path)
#
#   expect_true("import-df_events.RData" %in% saved_files)
# })
#
# test_that("df_events saved is dataframe", {
#   expect_is(df_events, 'data.frame')
# })
#
# test_that("df_events has type, player_id, time and game_id columns", {
#   expect_named(df_events, c("type","player_id","time","game_id"))
# })
#
# test_that("df_events isnt't empty", {
#   expect_true(nrow(df_events) > 1)
# })
#
# context("save_player_ids")
#
# players <- get_players("79")
# player_ids <- extract_player_ids(players)
#
# save_player_ids(player_ids)
# load(paste(data_path, "import-df_player_ids.RData", sep = "/")) # save and load back into memory
#
# test_that("file import-df_player_ids.RData is saved in project_root/data", {
#   saved_files <- dir(data_path)
#
#   expect_true("import-df_player_ids.RData" %in% saved_files)
# })
#
# test_that("file saved is dataframe", {
#   expect_is(df_player_ids, 'data.frame')
# })
#
# test_that("df_player_ids only has one column called player_id", {
#   expect_named(df_player_ids, "player_id")
# })
#
# test_that("df_player_ids isnt't empty", {
#   expect_true(nrow(df_player_ids) > 1)
# })
#
# # clean
# clean_files_to_remove <- dir(path = data_path,
#                              pattern = "import*")
# file.remove(paste(data_path, clean_files_to_remove, sep = "/"))
#
# rm(list = ls()) # remove objects in working directory
#
context("player_details_to_df")

complete_player <- get_player(player_id = "5110", competition_id = "1")
complete_player_details <- extract_player_details(complete_player)
df_complete_player <- player_details_to_df(complete_player_details)

no_stats_player <- get_player(player_id = "26152", competition_id = "1")
no_stats_player_details <- extract_player_details(no_stats_player)
df_no_stats_player <- player_details_to_df(no_stats_player_details)

empty_player <- get_player(player_id = "90794", competition_id = "1")
empty_player_details <- extract_player_details(empty_player)
df_empty_player <- player_details_to_df(empty_player_details)

test_that("returns dataframe", {
  expect_is(df_empty_player, "data.frame")
  expect_is(df_complete_player, "data.frame")
  expect_is(df_no_stats_player, "data.frame")
})

test_that("columns are position, birthdate, name and stats", {
  expected_columns <- c("position","birthdate","first_name","last_name","appearances","minutes_played")

  expect_named(df_complete_player, expected_columns)
  expect_named(df_no_stats_player, expected_columns)
  expect_named(df_empty_player, expected_columns)
})

test_that("stats columns empty when no stats available", {
  stats_columns <- c("appearances","minutes_played")

  df_empty_stats <- select(df_no_stats_player, one_of(stats_columns))

  nr_empty_columns <- apply(X = df_empty_stats,
                            MARGIN = 1, # row-wise calculation
                            FUN = function(x) sum(is.na(x)))

  expect_equal(nr_empty_columns, ncol(df_empty_stats))
})

