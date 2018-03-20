#' @import DiagrammeR
#' @param resources the resources as nodes (character vector)
#' @param info_obtained zhat information you got from each resource (character vector)
create_linear_resources_diagram <- function(resources, info_obtained) {

  # parameters
  nodes <- c(resources, "end result")

  # nodes and edges dataframes
  nodes_df <- create_node_df(n = length(nodes),
                             label = nodes,
                             shape = "rectangle",
                             fixedsize = FALSE)

  edges_df <- create_edge_df(from = 1:length(resources), # ids from nodes dataframe
                             to = 2:(length(resources) + 1), # +1 cause there's also an end result
                             label = info_obtained,
                             rel = )

  # create graph
  diagram <- create_graph(nodes_df, edges_df)

}

#' @import DiagrammeR
render_diagram_as_tree <- function(diagram) {
  render_graph(diagram, layout = "tree")
}

#' @import DiagrammeR
create_datasets_diagram <- function() {

  # parameters
  datasets <- c("events","games","players")
  join_keys <- c("player_id","game_id")

  # nodes and edges dataframes
  nodes_df <- create_node_df(n = length(datasets),
                             label = datasets,
                             shape = "rectangle",
                             fixedsize = FALSE)

  edges_df <- create_edge_df(from = c(1,1),
                             to = c(2,3),
                             label = c("game_id","player_id"))

  # create graph
  diagram <- create_graph(nodes_df, edges_df)

  return(diagram)
}
