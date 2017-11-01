library(rvest)
library(dplyr)
library(stringr)
library(rebus)
library(readr)


get_first_table_no <- function(season = NA) {
  
  link <- paste0("https://en.wikipedia.org/wiki/", season, "_NBA_season")
  url <- read_html(link)
  nodes <- html_nodes(url, "table")
  for(table_no in 1:length(nodes)) {
    ranking <- html_table(nodes[[table_no]], fill = T)
    if(str_extract(names(ranking)[1], pattern = one_or_more(WRD)) == "Atlantic") break
  }
  return(table_no)
}
  

get_table <- function(season = NA, table_no = NA) {
  
  link <- paste0("https://en.wikipedia.org/wiki/", season, "_NBA_season")
  url <- read_html(link)
  nodes <- html_nodes(url, "table")
  ranking <- html_table(nodes[[table_no]], fill = T)
  
  ranking[ , 1] <- str_replace(ranking[ , 1], pattern = START %R% WRD %R% or(" – ", "-"), "")
  
  ranking <- ranking %>%
    mutate(
      win = as.numeric(W), 
      lose = as.numeric(L),
      game_played = win + lose,
      win_rate = win / game_played,
      home_performance = Home,
      road_performance = Road,
      division_performance = Div,
      season = season,
      division = str_extract(names(ranking)[1], pattern = one_or_more(WRD)), 
      conference = if_else(division %in% c("Atlantic", "Central", "Southeast"), "East", "West")
    )
  
  names(ranking)[1] <- "team"
  
  ranking <- ranking %>% 
    select(
      season, 
      team, 
      conference, 
      division, 
      game_played, 
      win, 
      lose, 
      win_rate, 
      home_performance, 
      road_performance,
      division_performance
    ) %>%
    arrange(desc(win_rate, win))
  
}

get_overall_ranking <- function(start_year = NA) {
  
  end <- start_year + 1
  start_char <- as.character(start_year)
  end_char <- str_sub(as.character(end), start = -2)
  season <- paste0(start_char, "-", end_char)
  
  first_table_no <- get_first_table_no(season)
  
  if(start_year > 2004) {
    
    atlantic <- get_table(season, table_no = first_table_no)
    central <- get_table(season, table_no = first_table_no + 1)
    southeast <- get_table(season, table_no = first_table_no + 2)
    northwest <- get_table(season, table_no = first_table_no + 3)
    pacific <- get_table(season, table_no = first_table_no + 4)
    southwest <- get_table(season, table_no = first_table_no + 5)
    overall_ranking <- bind_rows(atlantic, central, southeast, northwest, pacific, southwest) %>%
      arrange(desc(win_rate, win))
    return(overall_ranking)
    
  } else if(start_year < 2004){
    
    atlantic <- get_table(season, table_no = first_table_no)
    central <- get_table(season, table_no = first_table_no + 1)
    midthwest <- get_table(season, table_no = first_table_no + 2)
    pacific <- get_table(season, table_no = first_table_no + 3)
    overall_ranking <- bind_rows(atlantic, central, midthwest, pacific) %>%
      arrange(desc(win_rate, win))
    
  }
  
}

ranking16_17 <- get_overall_ranking(start_year = 2016)
ranking15_16 <- get_overall_ranking(start_year = 2015)
ranking14_15 <- get_overall_ranking(start_year = 2014)

