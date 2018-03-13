#' @import httr
#' @title Get played fixtures.
#'
#' @description
#' \code{get_fixtures} returns info about fixtures played.
#'
#' @return
#' Response with information about each fixture (match id, attendance, ...)
#'
#' @details
#' The complete response body is returned including info like headers and status code.
#' The request parameters are the page size and level of detail. These can't be changed since there are only a few
#' sensible values. Page size is always fixed at 1000 (we don't expect more than 1000 games in a single season).
get_fixtures <- function(season_id, competition_id) {

}

extract_matchids <- function(response) {

}
