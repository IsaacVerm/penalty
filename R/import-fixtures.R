#' @seealso \code{\link{get_premier_league}}
#'
#' @title Get played fixtures.
#'
#' @description
#' \code{get_fixtures} returns info about fixtures played.
#'
#' @param competition_id Can be obtained through the competitions resource.
#' @param season_id Can be obtained through the competitions resource.
#'
#' @return
#' Response with information about each fixture (match id, attendance, ...)
#'
#' @details
#' The request parameters are the page size and level of detail. These can't be changed since there are only a few
#' sensible values. Page size is always fixed at 1000 (we don't expect more than 1000 games in a single season).
get_fixtures <- function(competition_id, season_id) {
  parameters <- list(comps = competition_id,
                     compSeasons = season_id,
                     pageSize = 1000)
  get_premier_league(resource = "fixtures",
                     parameters)
}

extract_match_ids <- function(response) {
  # response body
  body <- content(response)$content

  # ids
  ids <- body %>% map_chr(~.[["id"]])
  ids <- as.character(as.integer(ids))

  return(ids)
}
