#!/usr/bin/env Rscript
# Test all tutorials in the rtrainer package (quiet mode)

library(rtrainer)

# ANSI color codes
green <- "\033[32m"
red <- "\033[31m"
bold <- "\033[1m"
reset <- "\033[0m"

# Get all tutorial Rmd files
tuto_dir <- system.file("tutorials", package = "rtrainer")

if (tuto_dir == "") {
  stop("ERROR: Package not installed. Run 'make install' first.")
}

tuto_files <- Sys.glob(file.path(tuto_dir, "*", "*.Rmd"))

# Filter out non-tutorial files
tuto_files <- tuto_files[!grepl("mathjax\\.html|style\\.html|results/rmarkdown", tuto_files)]
tuto_files <- sort(tuto_files)

# Track results
failed <- character()
passed <- character()

# Suppress output during testing
for (i in seq_along(tuto_files)) {
  tuto <- tuto_files[i]
  tuto_name <- basename(dirname(tuto))
  
  result <- tryCatch({
    invisible(capture.output(check_tuto(tuto), type = "output"))
    invisible(capture.output(check_tuto(tuto), type = "message"))
    passed <- c(passed, tuto_name)
    "PASSED"
  }, error = function(e) {
    failed <- c(failed, tuto_name)
    as.character(e)
  })
}

# Summary only
cat(sprintf("%s%d%s passed, %s%d%s failed", 
            green, length(passed), reset,
            if(length(failed) > 0) red else green, length(failed), reset))

if (length(failed) > 0) {
  cat(" (")
  cat(paste(failed, collapse=", "))
  cat(")")
}
cat("\n")

if (length(failed) > 0) {
  quit(status = 1)
} else {
  quit(status = 0)
}
