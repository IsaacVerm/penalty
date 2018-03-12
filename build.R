# clear workspace
rm(list=ls())

# load packages
library(httr)
library(drake)
library(roxygen2)

# load functions
source("~/penalties/lib/functions/import.R")

# create workflow
workflow <- drake_plan(
  competitions = get_competitions()
)

# run workflow
make(workflow)

# clean up work done by make (only for testing purposes)
# clean(list = c(workflow$target, "workflow"),
#       destroy = TRUE)
