# Base image 
FROM rocker/geospatial:3.5.3

# install the linux libraries needed for plumber
RUN apt-get update -qq && apt-get install -y \
  libssl-dev \
  libcurl4-gnutls-dev

# create directories
RUN mkdir -p /home/project
RUN mkdir -p /home/project/input_data
RUN mkdir -p /home/project/output
RUN mkdir -p /data

## copy files
COPY main.R main.R
COPY make_report.R make_report.R
COPY config.yml config.yml
COPY report.Rmd report.Rmd
COPY install_packages.R install_packages.R

## install R-packages
RUN Rscript /install_packages.R

# open port 80 to traffic
EXPOSE 80

# when the container starts, start the main.R script
ENTRYPOINT ["Rscript", "main.R"]
