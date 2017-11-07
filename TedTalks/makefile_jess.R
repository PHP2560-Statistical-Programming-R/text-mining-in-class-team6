
source("TedTalks/01_check_install.R")   # check for and install all necessary packages 
source("TedTalks/02_clean_ted.R")     ## clean data
rmarkdown::render("TedTalks/jess_paper.Rmd", output_format = "html_document")

