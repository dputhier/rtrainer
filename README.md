# The rtrainer package

The rtrainer package offers a collection of tutorials for learning R. Contributions are welcome—feel free to submit an issue or a pull request. We are eager to expand the collection with new tutorials on a variety of topics.

# Installation

This version requires Bioconductor 3.22

Currently use the following command:

	   install.packages("devtools", dependencies=TRUE)
	   devtools::install_github("dputhier/rtrainer")

# Running the tutorials 

The tutorials can be found in `inst/tutorials/`. Only french versions
are available at the moment.

The list of available tutorials can be obtained using:

    library(learnr)
    learnr::available_tutorials("rtrainer")

Run a tutorial using the following command:

    learnr::run_tutorial("04_factors", "rtrainer")
    
# Docker file

A Docker file is available in `inst/docker` to facilitate the installation of the package and its dependencies.
Use the following command to build the Docker image:

    cd inst/docker
    docker build  --progress=plain  --no-cache -t rtrainer .

To run the image, use the following commands:

    docker run -e PASSWORD=bioc -p 8787:8787 rtrainer

The default login is `rstudio` and the password is `bioc`.
