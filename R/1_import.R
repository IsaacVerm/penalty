# file has number in front of it so it's loaded before the other files (import-resource) using it

#' @import httr
#' @title Helper for functions making GET request to the Premier League API.
#'
#' @description
#' \code{get_premier_league} is a helper for functions making GET request to the Premier League API.
#'
#' @return
#' Response including status code, body, ...
#'
#' @param parameters List of parameters
#' @param resource Type of resource you want to get
#'
#' @details
#' Function not called directly.
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
