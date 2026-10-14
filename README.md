# The rtrainer package

The rtrainer package offers a collection of tutorials for learning R. Contributions are welcome—feel free to submit an issue or a pull request. We are eager to expand the collection with new tutorials on a variety of topics.


# Installation for R 4.6.0 (skip all updates)

For the 2026–2027 academic year, rtrainer depends on R 4.6 and Bioconductor 3.23.


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


# Docker

    docker pull puthier/rtrainer:0.2.8
    docker run -e PASSWORD=bioc -p 8787:8787 puthier/rtrainer:0.2.8
    # login : rstudio // passwd: bioc



# Test all the tutorials

From the terminal run


     make test_tutorials

