load('data/full_data.Rda')
transcripts_clean <- full_data %>% unnest_tokens(word, transcript)

sentiments_bing <- transcripts_clean %>% inner_join(get_sentiments("bing")) 

sentiments_nrc <- transcripts_clean %>% inner_join(get_sentiments("nrc")) %>% filter(!word %in% c("like"))