#################################################################
##    set_verbosity
#################################################################
#' Set the verbosity level for the rtrainer package
#'
#' This function sets the verbosity level for the rtrainer package,
#' which controls the amount of information that is printed to the console by
#' the \code{\link{print_msg}} function. The verbosity level can be set to
#'  any non-negative integer, with higher values indicating more detailed output.
#'  By default, the verbosity level is set to 1.
#'
#' @param verbosity_value A non-negative integer indicating the verbosity level to be set.
#'
#' @return NULL
#'
#' @export
#'
#' @examples
#' # Set verbosity level to 2
#' set_verbosity(2)
#'
#' # Set verbosity level to 0
#' set_verbosity(0)

# 0 : No message
# 1 : Display only INFO type message
# 2 : Display both INFO and DEBUG type message

set_verbosity <- function(verbosity_value) {
  if (!is.null(verbosity_value) &
      verbosity_value >= 0 & is.numeric(verbosity_value)) {
    options(rtrainer_verbosity = verbosity_value)
  }
}

#################################################################
##    get_verbosity()
#################################################################
#' Get the current verbosity level.
#'
#' This function get the verbosity level of the rtrainer package which
#' controls the amount of information that is printed to the console by
#' the \code{\link{print_msg}} function.
#'
#'
#' @return A vector
#'
#' @export
#'
#' @examples
#' get_verbosity()
#'

get_verbosity <- function() {
  if (is.null(unlist(options()["rtrainer_verbosity"]))) {
    options(rtrainer_verbosity = 1)
  }
  return(options()$rtrainer_verbosity)
}

#################################################################
##    print_msg
#################################################################
#' Print a message based on the level of verbosity
#'
#' @param msg The message to be printed
#' @param msg_type The type of message, one of "INFO", "DEBUG", or "WARNING"
#'
#' @return None
#'
#' @export
#' @examples
#' opt_warn <- options()$warn
#' set_verbosity(1)
#' print_msg("Hello world!", "INFO")
#' set_verbosity(3)
#' print_msg("Debugging message", "DEBUG")
#' set_verbosity(0)
#' print_msg("Hello world!", "INFO")
#' print_msg("Debugging message", "DEBUG")
#' options(warn=-1)
#' print_msg("A warning message not displayed", "WARNING")
#' options(warn=opt_warn)
#' @keywords internal
print_msg <-
  function(msg,
           msg_type = c("INFO", "DEBUG", "WARNING", "STOP")) {
    
    msg_type <- match.arg(msg_type)
    
    if (is.null(unlist(options()["rtrainer_verbosity"]))) {
      options(rtrainer_verbosity = 1)
    }
    
    if (msg_type == "DEBUG"){
      if (unname(unlist(options()["rtrainer_verbosity"]) > 1))
        cat(paste("|-- DEBUG : ", msg, "\n"))
      
    }else if (msg_type == "WARNING"){
      warning("|-- WARNING : ", msg, call. = FALSE)
      
    }else if (msg_type == "STOP"){
      stop(paste0("|-- STOP : ", msg), call. = FALSE)
      
    }else{
      if (unname(unlist(options()["rtrainer_verbosity"]) > 0))
        cat(paste("|-- INFO : ", msg, "\n"))
    }
  }
