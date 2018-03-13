# clear workspace
rm(list=ls())

# load packages
library(drake)
library(R.utils)
library(here)

# load functions
R.utils::sourceDirectory(paste(here(),"R", sep = "/"))

# create workflow
workflow <- drake_plan(
  competitions = get_competitions(),
  competition_ids = extract_competition_ids(competitions, "Premier League"),
  fixtures = get_fixtures(competition_id = competition_ids$competition,
                          season_id = competition_ids$season[["2017/18"]])
)

# run workflow
make(workflow)

# clean up work done by make (only for testing purposes)
clean(list = c(workflow$target, "workflow"),
      destroy = TRUE)
