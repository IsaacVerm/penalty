#' @import httr
#' @title Create functions making GET request to the Premier League API.
#'
#' @description
#' \code{get_premier_league} creates functions making GET request to the Premier League API.
#'
#' @return
#' Function to make GET request to Premier League API.
#'
#' @param parameters List of parameters
#'
#' @details
#' Function created will return the complete response body including info like headers and status code.
get_premier_league <- function(parameters) {
  function() {
    url <- "https://footballapi.pulselive.com/football/competitions"
    headers <- c(Origin = "https://www.premierleague.com")

    response <- GET(url,
                    query = parameters,
                    add_headers(.headers = headers))

    return(response)
  }
}
