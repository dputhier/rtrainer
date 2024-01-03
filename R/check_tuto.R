#' Check the code/solutions of a tutorial
#' @param paths A vector containing tutorial paths.
#' @param file A connection, or a character string naming the file to print to. If "" (the default), prints to the standard output connection.  
#' @examples
#' tuto <- Sys.glob(file.path(system.file(package="rtrainer"), "tutorials", "*", "*.Rmd"))
#' check_tuto(tuto)
#' @export extract_text
#' 
#' 
check_tuto <- function(paths=NULL){
    
    old_path <- getwd()
    
    if(is.null(paths)){
      print_msg("Please provide a path", msg_type="STOP")
    }
    
    split_at <- function(x, pos) {
      unname(split(x, findInterval(x, pos)))
    }

    for(tuto in paths){
      setwd(old_path)
      print_msg(paste0(">>> START Processing : ", basename(tuto)))
      
      # read code chunks
      tmp_dir <- tempdir()
      tmp_path <- file.path(tempdir(), paste0(basename(tuto), ".R"))
      print_msg(paste0("Writing to file: ", tmp_path), msg_type="DEBUG")
      knitr::purl(tuto, output=tmp_path)
      code_chunk <- scan(file=tmp_path, what="character", sep = "\n")
      chunk_name_pos <- grep("^## ---", code_chunk)

      # Create a list of code chunk
      code_chunk_line <- split_at(1:length(code_chunk), chunk_name_pos)
      chunk_list <- lapply(code_chunk_line, function(x, code_chunk) code_chunk[x], code_chunk)
      chunk_list <- chunk_list[!grepl("eval=F", unlist(lapply(chunk_list,"[", 1)))]
      chunk_names <- stringr::str_match(unlist(lapply(chunk_list, "[", 1)), "## ----(.*)---")[,2]
      chunk_names <- gsub("---.*", "", chunk_names)
      chunk_names <- gsub(",.*", "", chunk_names)
      names(chunk_list) <- chunk_names
      
      # Does the chunk have a solution
      has_solution <- sapply(chunk_names, function(x,y) paste0(x, "-solution") %in% y, chunk_names)
      
      atest <- !is.na(chunk_names) & !has_solution & !grepl("-check$", chunk_names) & !"get_aa_liste_test2" %in% chunk_names
      print_msg(paste0(">>> Unselected chunks : ", names(chunk_list[!atest])))
      chunk_list <- chunk_list[atest]
      print_msg(paste0(">>> Selected chunks : ", names(chunk_list)))
      print(chunk_list)
      
      temp_file <- tempfile()
      all_code <- unlist(chunk_list)
      all_code <- append(all_code, "old_cwd <- getwd()", after = 0)
      all_code <- append(all_code, "setwd(old_cwd)", after = length(all_code))
      write(unlist(chunk_list), file = temp_file)

      print_msg(paste0(">>> Purl() output : ", tmp_path))
      print_msg(paste0(">>> Working file : ", temp_file))
      source(temp_file, echo = TRUE)
      print_msg(paste0(">>> END Processing : ", basename(tuto)))
    }
} 
