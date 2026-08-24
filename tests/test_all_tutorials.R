#!/usr/bin/env Rscript
# Test all tutorials in the rtrainer package

library(rtrainer)

# ANSI color codes
green <- "\033[32m"
red <- "\033[31m"
yellow <- "\033[33m"
blue <- "\033[34m"
bold <- "\033[1m"
reset <- "\033[0m"

cat(sprintf("\n%s%s=== Testing all rtrainer tutorials ===%s\n\n", bold, blue, reset))

# Get all tutorial Rmd files
tuto_dir <- system.file("tutorials", package = "rtrainer")

if (tuto_dir == "") {
  cat(sprintf("%sERROR: Package not installed. Installing...%s\n", red, reset))
  devtools::install()
  tuto_dir <- system.file("tutorials", package = "rtrainer")
}

tuto_files <- Sys.glob(file.path(tuto_dir, "*", "*.Rmd"))

# Filter out non-tutorial files
tuto_files <- tuto_files[!grepl("mathjax\\.html|style\\.html|results/rmarkdown", tuto_files)]
tuto_files <- sort(tuto_files)

cat(sprintf("Found %s%d%s tutorials to test\n\n", bold, length(tuto_files), reset))

# Track results
results <- list()
failed <- character()
passed <- character()
start_time <- Sys.time()

for (i in seq_along(tuto_files)) {
  tuto <- tuto_files[i]
  tuto_name <- basename(dirname(tuto))
  
  cat(sprintf("[%2d/%2d] Testing %s%-40s%s ", i, length(tuto_files), yellow, tuto_name, reset))
  flush.console()
  
  result <- tryCatch({
    invisible(capture.output({
      invisible(capture.output(check_tuto(tuto), type = "message"))
    }, type = "output"))
    cat(sprintf("%s✓ PASSED%s\n", green, reset))
    passed <- c(passed, tuto_name)
    "PASSED"
  }, error = function(e) {
    cat(sprintf("%s✗ FAILED%s\n", red, reset))
    cat(sprintf("    Error: %s\n", conditionMessage(e)))
    failed <- c(failed, tuto_name)
    as.character(e)
  })
  
  results[[tuto_name]] <- result
}

end_time <- Sys.time()
elapsed <- as.numeric(difftime(end_time, start_time, units = "secs"))

# Summary
cat(sprintf("\n%s%s=== Test Summary ===%s\n", bold, blue, reset))
cat(sprintf("Total:   %s%d%s\n", bold, length(tuto_files), reset))
cat(sprintf("Passed:  %s%d%s\n", green, length(passed), reset))
cat(sprintf("Failed:  %s%d%s\n", red, length(failed), reset))
cat(sprintf("Time:    %.1f seconds\n", elapsed))

if (length(failed) > 0) {
  cat(sprintf("\n%s%sFailed tutorials:%s\n", bold, red, reset))
  for (f in failed) {
    cat(sprintf("  - %s\n", f))
  }
  cat("\n")
  quit(status = 1)
} else {
  cat(sprintf("\n%s%s✓ All tutorials passed!%s\n\n", bold, green, reset))
  quit(status = 0)
}
