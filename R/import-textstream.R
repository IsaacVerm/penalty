get_textstream <- function(matchid) {
  resource <- paste("fixtures", matchid, "textstream/EN", sep = "/")

  parameters <- list(pageSize = 1000)

  response <- get_premier_league(resource,
                                 parameters)

  return(response)
}

extract_match_details <- function(response) {
  body <- content(response)

  extract_event_details <- function(raw_event) { # raw meaning containing superfluous info
    parsed_event <- list()

    parsed_event$time <- raw_event[["time"]][["secs"]]
    parsed_event$type <- raw_event[["type"]]
    parsed_event$player_id <- as.character(raw_event[["playerIds"]])

    # make sure all events have the same fields
    # e.g. time field doesn't exist for certain types (for example. doesn't make sense for line-up)
    add_missing_fields <- function(parsed_event) {
      necessary_fields <- c("time","type","player_id")
      missing_fields <- setdiff(necessary_fields, names(parsed_event))

      parsed_event[missing_fields] <- NA

      return(parsed_event)
    }

    event <- add_missing_fields(parsed_event)

    return(event)
  }

  match_details <- list()
  match_details$gameweek <- as.character(body[["fixture"]][["gameweek"]][["gameweek"]])
  match_details$attendance <- as.character(body[["fixture"]][["attendance"]])

  raw_events <- body[["events"]][["content"]]
  match_details$events <- raw_events %>%
    map(extract_event_details)

  return(match_details)
}
