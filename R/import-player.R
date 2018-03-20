#' @import httr
get_player <- function(player_id, competition_id) {
  resource <- paste("stats","player", player_id, sep = "/")

  parameters <- list(comps = competition_id)

  response <- get_premier_league(resource,
                                 parameters)

  return(response)
}

#' @import httr
#' @import purrr
extract_player_details <- function(response) {
  # sometimes response is succesful but empty
  empty_response <- length(response$content) == 0
  if (empty_response) {
    return("no player details found")
  }

  # response body
  body <- content(response)

  # stable attributes
  entity <- body[["entity"]]
  name <- entity[["name"]]

  player_details <- list(position = entity[["info"]][["positionInfo"]],
                         birthdate = entity[["birth"]][["date"]][["label"]],
                         name = list(first = name[["first"]],
                                     last = name[["last"]]))

  # stats
  player_details$stats = list()
  stats <- body[["stats"]]

  names(stats) <- stats %>%
    map_chr(~.[["name"]])# give object stats names according to stats in each element

  player_details[["stats"]][["time_played"]] <- list(appearances = stats[["appearances"]][["value"]],
                                                     minutes_played = stats[["mins_played"]][["value"]])

  return(player_details)
}
