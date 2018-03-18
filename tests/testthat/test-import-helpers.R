# # setup common to all tests
#
# if (length(ls()) > 0) {
#   rm(list = ls()) # remove objects in working directory (if any)
# }
#
# project_root <- here::here()
# data_path <- paste(project_root,"data", sep = "/") # variables used by all tests
#
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
