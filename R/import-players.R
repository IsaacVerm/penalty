# 1000 is maximum page size, never more than 1000 players max
#' @import httr
get_players <- function(season_id) {
  resource = "players"

  parameters = list(pageSize = 1000,
                    compSeasons = season_id)

  response <- get_premier_league(resource, parameters, timeout_in_sec = 300)

  return(response)
}

#' @import httr
#' @import purrr
extract_player_ids <- function(response) {
  body <- content(response)

  player_ids <- body[["content"]] %>%
    map_chr(~as.character(as.integer(.[["playerId"]])))

  return(player_ids)
}
