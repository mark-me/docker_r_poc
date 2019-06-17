docker run -d --name rstudio -v $HOME:/home/`whoami` -e PASSWORD=blu3b1rd -p 8787:8787 report_generator
