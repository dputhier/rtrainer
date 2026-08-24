#!/usr/bin/env Rscript
# List all available tutorials

library(rtrainer)

tuto_dir <- system.file("tutorials", package = "rtrainer")
tuto_files <- Sys.glob(file.path(tuto_dir, "*", "*.Rmd"))
tuto_files <- tuto_files[!grepl("mathjax\\.html|style\\.html|results/rmarkdown", tuto_files)]
tuto_files <- sort(tuto_files)

cat(sprintf("\nAvailable tutorials (%d total):\n\n", length(tuto_files)))

for (i in seq_along(tuto_files)) {
  tuto_name <- basename(dirname(tuto_files[i]))
  cat(sprintf("%2d. %s\n", i, tuto_name))
}

cat("\n")
