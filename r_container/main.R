library(plumber)
setwd("~/R scripts/docker_r_poc/r_container")
r <- plumb("make_report.R")
r$run(port=80, host="0.0.0.0")

