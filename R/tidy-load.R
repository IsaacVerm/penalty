# all objects have the same name, silly me
# so you need a workaround to load the data
load_for_same_name <- function(type_of_data, identifier) {
  load(paste0("/home/rstudio/penalty/data/", identifier, "-import-df_", type_of_data, ".RData"))

  if (type_of_data == "player") {
    return(df_player_details)
  }

  if (type_of_data == "events") {
    return(df_events)
  }

  if (type_of_data == "games") {
    return(df_games)
  }
}

#' @import stringr
get_identifiers <- function(type_of_data) {
    regex <- paste0("\\d+-import-df_", type_of_data, "\\.RData")

    data_path = paste(here::here(), "data", sep = "/")

    file_names <- list.files(path = data_path,
                             pattern = regex)

    identifiers <- stringr::str_extract(string = file_names,
                               pattern = "\\d+")

    return(identifiers)
}

# temp test

games_identifiers <- get_identifiers("games")

games <- games_identifiers %>%
  map(~load_for_same_name(type_of_data = "games", identifier = .))
