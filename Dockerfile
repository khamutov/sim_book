FROM ubuntu:22.04

ENV R_BASE_VERSION 4.1.2

RUN apt-get update && \
  apt-get install -y wget

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        libopenblas0-pthread \
        r-cran-docopt \
        r-base=${R_BASE_VERSION}-* \
        r-base-dev=${R_BASE_VERSION}-* \
        r-base-core=${R_BASE_VERSION}-* \
        r-recommended=${R_BASE_VERSION}-*

RUN apt-get install -y pandoc pandoc-citeproc pandoc-citeproc-preamble

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

ENV PATH="/root/miniconda3/bin:${PATH}"
RUN conda --version

ADD sim_book.env.yml sim_book.env.yml
RUN conda env create -n sim_book --file sim_book.env.yml

RUN Rscript -e 'install.packages(c("rmarkdown","bookdown", "reticulate"))'

# Set the locale
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["Rscript", "-e", "bookdown::render_book(\"/build/input\")"]
