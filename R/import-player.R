#' @import httr
get_player <- function(player_id, competition_id) {
  resource <- paste("stats","player", player_id, sep = "/")

  parameters <- list(comps = competition_id)

  response <- get_premier_league(resource,
                                 parameters)

  return(response)
}

save_player_details <- function(player_details) {
  random_identifier <- as.character(sample(1000000000,1))

  save_name <- paste(random_identifier, "import-df_player.RData", sep = "-")
  save(player_details, file = paste(here::here(),"data","temp", save_name, sep = "/"))
}

#' @import httr
extract_player_details <- function(response) {

  # columns to extract
  columns_basic_info <- c("player_id","position","birthdate","first_name","last_name")

  # create empty dataframe if response is empty
  create_empty_df <- function(column_names) {
    df <- as.data.frame(matrix(data = rep(NA, length(column_names)),
                               nrow = 1))
    names(df) <- column_names

    return(df)
  }

  empty_response <- length(response$content) == 0
  if (empty_response) {
    return(create_empty_df(columns_basic_info))
  }

  # response body
  body <- httr::content(response)

  # default values if a variable is missing
  player_details <- data.frame(player_id = NA,
                               position = NA,
                               birthdate = NA,
                               first_name = NA,
                               last_name = NA)

  # access player details
  try(player_details[["player_id"]] <- body[["entity"]][["id"]], silent = TRUE)
  try(player_details[["position"]] <- body[["entity"]][["info"]][["positionInfo"]], silent = TRUE)
  try(player_details[["birthdate"]] <- body[["entity"]][["birth"]][["date"]][["label"]], silent = TRUE)
  try(player_details[["first_name"]] <- body[["entity"]][["name"]][["first"]], silent = TRUE)
  try(player_details[["last_name"]] <- body[["entity"]][["name"]][["last"]], silent = TRUE)

  return(player_details)
}

save_player_info <- function(player_id, competition_id) {
  player <- get_player(player_id, competition_id)
  player_details <- extract_player_details(player)
  save_player_details(player_details)
}

