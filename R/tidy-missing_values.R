calc_n_na_by_var <- function(df) {
  df %>% 
    purrr::map(~sum(is.na(.))) %>%
    as.data.frame() %>% 
    tidyr::gather() %>% 
    setNames(c("variable","count"))
}

#' @import ggplot2
plot_count_bar <- function(variable = "variable", count_df) {
  ggplot(data = count_df,
         mapping = aes_string(x = variable, y = "count")) +
    geom_col()
}

