# The rtrainer package

The rtrainer package offers a collection of tutorials for learning R. Contributions are welcome—feel free to submit an issue or a pull request. We are eager to expand the collection with new tutorials on a variety of topics.

# Installation for R 4.5.0

This version requires Bioconductor 3.22


    install.packages(c("remotes", "devtools"), dependencies=TRUE, ask = FALSE)
    if (!require("BiocManager", quietly = TRUE))
        install.packages("BiocManager", dependencies=TRUE, ask = FALSE)
    BiocManager::install(version = "3.22", ask=FALSE)
    remotes::install_github("dputhier/rtrainer@778b6f2b47dd57dbe57ecedc169812b8a3aa4f45")


# Installation for R 4.6.0 (skip all updates)

This version requires Bioconductor 3.23


    install.packages(c("remotes", "devtools"), dependencies=TRUE, ask = FALSE)
    if (!require("BiocManager", quietly = TRUE))
        install.packages("BiocManager", dependencies=TRUE, ask = FALSE)
    BiocManager::install(version = "3.23", ask=FALSE)
    remotes::install_github("dputhier/rtrainer@v0.2.7")
 


# Running the tutorials 

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

# Test all the tutorials

From the terminal run


     make test_tutorials

