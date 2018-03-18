#' @import DiagrammeR
#' @param resources the resources as nodes (character vector)
#' @param info_obtained zhat information you got from each resource (character vector)
create_linear_resources_diagram <- function(resources, info_obtained) {
  
  # parameters
  nodes <- c(resources, "end result")
  
  # nodes and edges dataframes
  nodes_df <- create_node_df(n = length(nodes), # +1 cause there's also an end result
                             label = nodes,
                             shape = "rectangle",
                             fixedsize = FALSE)
  
  edges_df <- create_edge_df(from = 1:3, # ids from nodes dataframe
                             to = 2:4,
                             label = info_obtained)
  
  # create graph
  diagram <- create_graph(nodes_df, edges_df)
  
}

#' @import DiagrammeR
render_diagram_as_tree <- function(diagram) {
  render_graph(diagram, layout = "tree")
}