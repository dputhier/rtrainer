#!/usr/bin/env Rscript
# Test a specific tutorial by name or number

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  cat("Usage: Rscript test_single_tutorial.R <tutorial_name_or_number>\n")
  cat("Example: Rscript test_single_tutorial.R 02_vectors\n")
  cat("Example: Rscript test_single_tutorial.R 2\n")
  quit(status = 1)
}

library(rtrainer)

tuto_input <- args[1]

# Get all tutorial Rmd files
tuto_dir <- system.file("tutorials", package = "rtrainer")
tuto_files <- Sys.glob(file.path(tuto_dir, "*", "*.Rmd"))
tuto_files <- tuto_files[!grepl("mathjax\\.html|style\\.html|results/rmarkdown", tuto_files)]
tuto_files <- sort(tuto_files)

# Find the tutorial
if (grepl("^[0-9]+$", tuto_input)) {
  # Input is a number
  idx <- as.integer(tuto_input)
  if (idx < 1 || idx > length(tuto_files)) {
    cat(sprintf("Error: Tutorial number must be between 1 and %d\n", length(tuto_files)))
    quit(status = 1)
  }
  tuto_file <- tuto_files[idx]
} else {
  # Input is a name
  matches <- grep(tuto_input, tuto_files, value = TRUE)
  if (length(matches) == 0) {
    cat(sprintf("Error: No tutorial found matching '%s'\n", tuto_input))
    quit(status = 1)
  } else if (length(matches) > 1) {
    cat(sprintf("Error: Multiple tutorials found matching '%s':\n", tuto_input))
    for (m in matches) {
      cat(sprintf("  - %s\n", basename(dirname(m))))
    }
    quit(status = 1)
  }
  tuto_file <- matches[1]
}

tuto_name <- basename(dirname(tuto_file))
cat(sprintf("Testing tutorial: %s\n\n", tuto_name))

result <- tryCatch({
  check_tuto(tuto_file)
  cat(sprintf("\n✓ Tutorial '%s' PASSED\n", tuto_name))
  quit(status = 0)
}, error = function(e) {
  cat(sprintf("\n✗ Tutorial '%s' FAILED\n", tuto_name))
  cat(sprintf("Error: %s\n", conditionMessage(e)))
  quit(status = 1)
})
