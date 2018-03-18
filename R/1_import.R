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
#' @param parameters list of parameters
#' @param resource type of resource you want to get
#' @param timeout_in_sec after this amount of time a time-out error is thrown
#' @param wait_in_sec idle time in seconds before actual request (as a matter of decency it's common not to flood the server with requests)
#'
#' @details
#' Function not called directly.
get_premier_league <- function(resource, parameters, timeout_in_sec = 5, wait_in_sec = 1) {
    # wait
    Sys.sleep(wait_in_sec)

    # url
    premier_league_url <- "https://footballapi.pulselive.com/football"
    resource_url <- paste(premier_league_url, resource, sep = "/")

    # headers
    headers <- c(Origin = "https://www.premierleague.com")

    # request
    response <- GET(resource_url,
                    query = parameters,
                    add_headers(.headers = headers),
                    timeout(timeout_in_sec))

    return(response)
    }
