# The rtrainer package

This software is still in development. 

The rtrainer package aims at providing a set of tutorials for learning R.

# Installation

Currently use the following command:

	  make install

# Running the tutorials 

The tutorials can be found in `inst/tutorials/`. Only french versions
are available at the moment.

The list of available tutorials can be obtained using:

    library(learnr)
    learnr::available_tutorials("rtrainer")
    learnr::run_tutorial("03_indexations_des_vecteurs", "rtrainer")