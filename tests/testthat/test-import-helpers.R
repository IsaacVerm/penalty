# # setup common to all tests
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
# context("save_match_details")
#
# # setup
# match_ids <- c("22643","22645","22342", "22344") # e.g. 22643 has no attendance value
# responses <- match_ids %>%  map(get_textstream)
# list_match_details <- responses %>% map(extract_match_details) # get list of match_details
#
# save_match_details(list_match_details)
# load(paste(data_path, "import-df_match_details.RData", sep = "/")) # save and load back into memory
#
# # run tests
# test_that("file import-df_match_details.RData is saved in project_root/data", {
#   saved_files <- dir(data_path)
#
#   expect_true("import-df_match_details.RData" %in% saved_files)
# })
#
# test_that("df_match_details saved is dataframe", {
#   expect_is(df_match_details, 'data.frame')
# })
#
# test_that("df_match_details has gameweek, attendance, type_of_event, player_id and time_of_event columns", {
#   expect_named(df_match_details, c("gameweek", "attendance", "type_of_event", "time_of_event", "player_id"))
# })
#
# test_that("df_match_details isnt't empty", {
#   expect_true(nrow(df_match_details) > 1) # if  you put placeholder 0 would still pass
# })
#
# context("save_player_ids")
#
# # setup
# players <- get_players("79")
# player_ids <- extract_player_ids(players)
#
# save_player_ids(player_ids)
# load(paste(data_path, "import-df_player_ids.RData", sep = "/")) # save and load back into memory
#
# # run tests
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
