# Run all scripts

source("gather_data_01.R")
source("tidy_data_02.R")
source("Q1_common_words.R")
source("Q2_character.R")
rmarkdown::render("textmining_Annie.Rmd", output_format = "html_document")