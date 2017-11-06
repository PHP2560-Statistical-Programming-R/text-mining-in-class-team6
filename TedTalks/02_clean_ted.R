##read in main data set
ted_main <- read_csv("TedTalks/data/ted_main.csv")

##read in transcripts
transcripts <- read_csv("TedTalks/data/transcripts.csv")

###combine data sets
full_data <- inner_join(ted_main, transcripts, by = "url")

###remove any text in the transcript that is surrounded by parenthesis

for (i in 1:nrow(full_data)){
  full_data[i, "transcript"] = 
    str_replace_all(
      full_data[i, "transcript"],
      pattern = "\\([^()]+\\)", 
      " "
    )
}

save(full_data, file = "TedTalks/data/full_data.Rda")
