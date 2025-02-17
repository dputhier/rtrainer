# The rtrainer package

This software is still in development. 

The rtrainer package aims at providing a set of tutorials for learning R.

# Note for dev

To deploy on ShinyApp these lines should be discarded from tutorials:

               includes:
                   before_body: !expr system.file(file.path("tutorials", "style.html"),package="rtrainer")

# Installation

Currently use the following command:

	  install.packages("devtools")
   	  devtools::install_github("dputhier/rtrainer")

	  # Currently for the english version
	  devtools::install_github("dputhier/rtrainer@english_version")

	  # Currently for the french (old) version
	  devtools::install_github("dputhier/rtrainer@french_ver")


# Running the tutorials 

The tutorials can be found in `inst/tutorials/`. Only french versions
are available at the moment.

The list of available tutorials can be obtained using:

    library(learnr)
    learnr::available_tutorials("rtrainer")

Run a tutorial using the following command:

    learnr::run_tutorial("04_factors", "rtrainer")
    
