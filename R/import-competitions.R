#' @seealso \code{\link{get_premier_league}}
#'
#' @title Get info about the competitions available.
#'
#' @description
#' \code{get_competitions} returns info about the competitions available.
#'
#' @return
#' Response with information about each competition (id, label, level, ...)
#'
#' @details
#' \code{get_competitions} is based on \code{get_premier_league}.
#' The request parameters are the page size and level of detail. These can't be changed since there are only a few
#' sensible values. Page size is always fixed at 100 (we don't expect there would ever be more than 100 competitions
#' in the UK) and the level of detail is 2 (meaning we get the maximum of info). Lower levels of detail don't include
#' the season id and in most cases the season id is the main reason for running this function.
get_competitions <- function() {
  get_premier_league(resource = "competitions",
                     parameters = list(pageSize = 100,
                                       detail = 2))
}

#' @import httr
#' @import purrr
#' @title Get the ids for a specific competition.
#'
#' @description
#' \code{extract_season_ids} gets the ids for a specific competition.
#'
#' @return
#' List of both the competition id and the season ids. The competition id is a single number, the season ids are
#' a named character vector with id by season.
#'
#' @details
#' You can only get the season ids for a single competition at a time
#' @param response The response returned by \code{get_competitions}.
#' @param competition Competition you want the ids for e.g. Premier League.
extract_competition_ids <- function(response, competition) {
  # response body
  body <- content(response)

  # all available competitions
  competition_names <- body$content %>%
    map_chr(~.[["description"]])

  # select only competition we need
  competition_ind <- which(competition_names == competition)
  selected_competition <- body$content[[competition_ind]]

  # competition id
  competition_id <- as.character(selected_competition[["id"]])

  # season ids
  season_ids <- selected_competition[["compSeasons"]] %>%
    map_chr(~.[["id"]])
  season_ids <- as.character(as.integer(season_ids))
  names(season_ids) <- selected_competition[["compSeasons"]] %>%
    map_chr(~.[["label"]])

  # bundle ids together
  ids = list(competition = competition_id,
             season = season_ids)

  return(ids)
}



