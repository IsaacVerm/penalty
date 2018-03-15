# clear workspace
rm(list=ls())

# clean up work done by make (only for testing purposes)
clean(destroy = TRUE)

# load package
library(drake)

# build - import
selected_competition <- "Premier League"
selected_season <- "2017/18"

import_workflow <- drake_plan(
  competitions = get_competitions(),
  competition_ids = extract_competition_ids(competitions, selected_competition),
  fixtures = get_fixtures(competition_id = competition_ids$competition,
                          season_id = competition_ids$season[[selected_season]]),
  match_ids = extract_match_ids(fixtures),
  textstreams = match_ids[1:10] %>% map(get_textstream),
  # textstreams = match_ids %>% map(get_textstream)
  match_details = textstreams %>% map(extract_match_details),
  players = get_players(competition_ids$season[[selected_season]]),
  player_ids = extract_player_ids(players)
)

# run workflow
make(import_workflow)
