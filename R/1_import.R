# file has number in front of it so it's loaded before the other files (import-resource) using it

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
get_premier_league <- function(resource, parameters) {

    # url
    premier_league_url <- "https://footballapi.pulselive.com/football"
    resource_url <- paste(premier_league_url, resource, sep = "/")

    # headers
    headers <- c(Origin = "https://www.premierleague.com")

    # request
    response <- GET(resource_url,
                    query = parameters,
                    add_headers(.headers = headers))

    return(response)
    }
