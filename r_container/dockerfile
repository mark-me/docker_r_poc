# Base image https://hub.docker.com/u/oliverstatworx/
FROM graydon/base-r-tidyverse:latest

## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output

## copy files
COPY myScript.R myScript.R

## run the script
CMD Rscript myScript.R
