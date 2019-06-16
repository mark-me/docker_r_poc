#* @get /make_report
make_report <- function(id_company){
  # convert the input to a number

  read_yaml("config.yml")
  config$id_company <- id_company
  write_yaml(config, "config.yml") 
  
  # Render report
  #rmarkdown::render("report.Rmd",
  #                  output_file="~/report/report/report.html",
  #                  encoding = "utf-8")

  list(msg = paste0("The message is: '", id_company, "'"))
}
