replace_empty_with_na <- function(list) {
  empty_ind <- sapply(list, function(x) is_empty(x))
  list[empty_ind] <- NA
  return(list)
}

#' @import purrr
#' @import dplyr
# do the absolute minimum to have your data in dataframe format
# list as argument because you want to save a lot of matches in a single dataframe
save_events <- function(list_match_details, group_nr) {

  # create dataframe single event
  extract_game_id <- function(match) {
    game_id <- match[["game"]][["game_id"]]

    return(game_id)
  }

  create_df_single_event <- function(event, game_id) {
    event <- event %>%
      replace_empty_with_na(.)

    df_event <- as.data.frame(event)
    df_event$game_id <- game_id

    return(df_event)
  }

  # extract game ids
  game_ids <- list_match_details %>%
    map_chr(~extract_game_id(.))

  # extract events
  list_events <- list_match_details %>%
    map(~.[["events"]])

  events_per_match <- list_events %>%
    map_int(~length(.))

  list_events <- flatten(list_events)

  # apply this function to all events
  game_ids_rep <- map2(.x = game_ids,
                       .y = events_per_match,
                       ~rep(.x, .y))
  game_ids_rep <- unlist(game_ids_rep)

  df_events <- map2(.x = list_events,
                    .y = game_ids_rep,
                    ~create_df_single_event(event = .x, game_id = .y)) %>%
    bind_rows(.)

  # save
  save_name <- paste(group_nr, "import-df_events.RData", sep = "-")
  save(df_events, file = paste(here::here(),"data", save_name , sep = "/"))
}

#' @import purrr
save_games <- function(list_match_details, group_nr) {

  # create dataframe single game
  create_df_single_game <- function(game) {
    game <- replace_empty_with_na(game)
    df_game <- as.data.frame(game)

    return(df_game)
  }

  # extract games
  list_games <- list_match_details %>%
    map(~.[["game"]])

  # apply this function to all games
  df_games <- list_games %>%
    map(~create_df_single_game(.)) %>%
    bind_rows(.)

  # save
  save_name <- paste(group_nr, "import-df_games.RData", sep = "-")
  save(df_games, file = paste(here::here(),"data", save_name, sep = "/"))

}

# other way of doing this: no list but each player saved individually and then joined together later on during wrangling
player_details_to_df <- function(player_details) {

  basic_column_names <- c("position","birthdate","first_name","last_name")
  full_column_names <- c(basic_column_names,"appearances","minutes_played") # including stats

  # possible to have succesful response but empty
  create_empty_df <- function() {

    mat <- matrix(rep(NA, length(full_column_names)),
                  nrow = 1)

    empty_df <- data.frame(mat)

    names(empty_df) <- full_column_names

    return(empty_df)
  }

  if (player_details == "no player details found") {
    return(create_empty_df())
  }

  # list to dataframe
  df_player_details <- data.frame(as.list(unlist(player_details)))

  # readable column names
  contains_stat_columns <- any(grepl("stats", names(df_player_details)))

  if (contains_stat_columns) {
    names(df_player_details) <- full_column_names
  } else {
    names(df_player_details) <- basic_column_names
    df_player_details$appearances <- NA
    df_player_details$minutes_played <- NA
  }

  return(df_player_details)
}

save_player_details <- function(df_player_details) {

}
