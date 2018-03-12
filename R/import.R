library(httr)
library(purrr)

#' @title Get info about the competitions available.
#'
#' @description
#' \code{get_competitions} returns info about the competitions available.
#'
#' @return
#' Response with information about each competition (id, label, level, ...)
#'
#' @details
#' The complete response body is returned including info like headers and status code.
#' The request parameters are the page size and level of detail. These can't be changed since there are only a few
#' sensible values. Page size is always fixed at 100 (we don't expect there would ever be more than 100 competitions
#' in the UK) and the level of detail is 2 (meaning we get the maximum of info). Lower levels of detail don't include
#' the season id and in most cases the season id is the main reason for running this function.
get_competitions <- function() {
  url <- "https://footballapi.pulselive.com/football/competitions"

  parameters <- list(pageSize = 100,
                     detail = 2)

  headers <- c(Origin = "https://www.premierleague.com")

  competitions <- GET(url,
                      query = parameters,
                      add_headers(.headers = headers))

  return(competitions)
}

#' @title Get the season ids for a specific competition.
#'
#' @description
#' \code{extract_season_ids} gets the season ids for a specific competition.
#'
#' @return
#' Named character vector with id by season
#'
#' @details
#' You can only get the season ids for a single competition at a time
#' @param response The response returned by \code{get_competitions}.
#' @param competition Competition you want the ids from e.g. Premier League.
extract_season_ids <- function(response, competition) {
  # response body
  body <- content(response)

  # all available competitions
  competition_names <- body$content %>%
    map_chr(~.[["description"]])

  # select only competition we need
  competition_ind <- which(competition_names == competition)
  selected_competition <- body$content[[competition_ind]]

  # get season ids
  season_ids <- selected_competition[["compSeasons"]] %>%
    map_chr(~.[["id"]])
  season_ids <- as.character(as.integer(season_ids))
  names(season_ids) <- selected_competition[["compSeasons"]] %>%
    map_chr(~.[["label"]])

  return(season_ids)
}

get_fixtures <- function(season, competition) {
  status <- status_code(GET("http://httpbin.org/get"))
  # writeLines(status, "status.txt")
}

extract_matchids <- function(fixtures_json) {

}

get_textstream <- function(matchid) {

}

extract_events <- function(textstream_json) {

}

