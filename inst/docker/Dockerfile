FROM bioconductor/bioconductor_docker:3.22

RUN git config --global credential.helper store && \
    git config --global user.name "Your Name" && \
    git config --global user.email "you@example.com"

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    wget \
    curl \
    git \
    pandoc \
    libgit2-dev \
    && rm -rf /var/lib/apt/lists/*


RUN R -e "options(timeout = 10000); install.packages('devtools')"
RUN R -e "options(timeout = 10000); options(download.file.method = 'wget'); devtools::install_github('dputhier/rtrainer')"

##  --  Building --
# docker build   --no-cache -t rtrainer .


## -- Running --
## -- login: rstudio / passwd: bioc --
# docker run \
#        -e PASSWORD=bioc \
#        -p 8787:8787 \
#        rtrainer2
# -- R Console --
# learnr::available_tutorials("rtrainer")
# learnr::run_tutorial("21_poisson", "rtrainer")