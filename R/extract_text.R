#' Delete the code from the tutorials and extract the text.
#' @param paths A vector containing tutorial paths.
#' @param file A connection, or a character string naming the file to print to. If "" (the default), prints to the standard output connection.  
#' @examples
#' tuto <- Sys.glob(file.path(system.file(package="rtrainer"), "tutorials", "*", "*.Rmd"))
#' out <- tempfile()
#' extract_text(tuto, file=out)
#
#' @export extract_text
#' 
extract_text <- function(paths=NULL, file=""){
  
  if(is.null(paths)){
    print_msg("Please provide a path", msg_type="STOP")
  }
  
  
  for(tuto in paths){
   
    file_tmp <- scan(file=tuto, what="character", sep = "\n")
    in_chunk <- FALSE
    dist_from_chunk <- 1
    
    for(line in file_tmp){

       if(length(grep("^```\\{", line))){
         in_chunk <- TRUE
         dist_from_chunk <- 0
       }
       
       if(length(grep("^```\\s*$", line))){
         in_chunk <- FALSE
       }
      
      if(!in_chunk){
        if(dist_from_chunk == 0){
          dist_from_chunk <- 1
        }else{
          cat(line, file=file, append = TRUE, fill = TRUE)
        }
      }
        
    }
  }
}
