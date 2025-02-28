# The rtrainer package

The rtrainer package offers a collection of tutorials for learning R. Contributions are welcome—feel free to submit an issue or a pull request. We are eager to expand the collection with new tutorials on a variety of topics. 

# Note for dev

To deploy on ShinyApp these lines should be discarded from tutorials:

               includes:
                   before_body: !expr system.file(file.path("tutorials", "style.html"),package="rtrainer")

# Installation

Currently use the following command:

	  install.packages("devtools")
   	  devtools::install_github("dputhier/rtrainer")

# Running the tutorials 

The tutorials can be found in `inst/tutorials/`. Only french versions
are available at the moment.

The list of available tutorials can be obtained using:

    library(learnr)
    learnr::available_tutorials("rtrainer")

Run a tutorial using the following command:

    learnr::run_tutorial("04_factors", "rtrainer")
    
