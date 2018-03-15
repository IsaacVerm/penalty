# do the absolute minimum to have your data in dataframe format
# list as argument because you want to save a lot of matches in a single dataframe
save_match_details <- function(list_match_details) {
  extract_single_value <- function(field, list) {
    value <- list %>% map(~.[[field]])
    
    return(value)
  }
  
  extract_event_values <- function(field, list_match_details) {
    values <- list_match_details %>%
      map(~extract_single_value(list = .[["events"]],
                                field))
    values <- flatten(values)
          
    return(values)
  }
  
  replace_empty_with_na <- function(list) {
    empty_ind <- sapply(list, function(x) is_empty(x))
    list[empty_ind] <- NA
    return(list)
  }
  
  df_event_details <- data.frame(type_of_event = unlist(extract_event_values("type", list_match_details)),
                                 time_of_event = unlist(extract_event_values("time", list_match_details)))
  df_event_details$player_id <- replace_empty_with_na(
    extract_event_values("player_id", list_match_details)
  ) # list within list because multiple players can be involved in the same event
  
  nr_events_by_match <- list_match_details %>% map_int(~length(.[["events"]]))
  df_single_value_details <- data.frame(gameweek = unlist(extract_single_value("gameweek", list_match_details)),
                                        attendance = unlist(extract_single_value("attendance", list_match_details)))
  df_single_value_details <- df_single_value_details %>% 
    tidyr::uncount(weights = nr_events_by_match)
  
  df_match_details <- dplyr::bind_cols(df_single_value_details, df_event_details)
  
  save(df_match_details, file = paste(here(),"data","import-df_match_details.RData", sep = "/"))
}

save_player_ids <- function(list_player_ids) {
  
}