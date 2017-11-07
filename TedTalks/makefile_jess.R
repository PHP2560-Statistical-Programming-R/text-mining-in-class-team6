
source("TedTalks/01_check_install.R")   # check for and install all necessary packages 
source("TedTalks/02_clean_ted.R")     ## clean data
rmarkdown::render("TedTalks/jess_paper.Rmd", output_format = "html_document")
<<<<<<< HEAD

=======
#rmarkdown::render("TedTalks/blain_paper.Rmd", output_format = "html_document")
>>>>>>> 439f0de2f05a3de1d2449abb85dccf4d06673d57
