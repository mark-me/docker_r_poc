#* @get /make_report
make_report <- function(id_company){

  library(yaml)
  config <- read_yaml("config.yml")
  config$id_company <- id_company
  write_yaml(config, "config.yml") 
  
  # Render report
  rmarkdown::render("report.Rmd",
                    output_file=paste0("report/", id_company, "_report.html"),
                    encoding = "utf-8")

  list(msg = paste0("The finished the report for: '", id_company, "'"),
       report_url = paste0("http://172.26.23.237/", id_company, "_report.html"))
}
