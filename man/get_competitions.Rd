% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import-competitions.R
\name{get_competitions}
\alias{get_competitions}
\title{Get info about the competitions available.}
\usage{
get_competitions()
}
\value{
Response with information about each competition (id, label, level, ...)
}
\description{
\code{get_competitions} returns info about the competitions available.
}
\details{
\code{get_competitions} is based on \code{get_premier_league}.
The request parameters are the page size and level of detail. These can't be changed since there are only a few
sensible values. Page size is always fixed at 100 (we don't expect there would ever be more than 100 competitions
in the UK) and the level of detail is 2 (meaning we get the maximum of info). Lower levels of detail don't include
the season id and in most cases the season id is the main reason for running this function.
}
\seealso{
\code{\link{get_premier_league}}
}
