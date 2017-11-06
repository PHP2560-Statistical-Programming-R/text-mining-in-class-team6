#### what are the most used words among all ted talks###
load("TedTalks/data/sentiments_bing.Rda")

word_freq <- sentiments_bing %>%
  group_by(word) %>%
  count() %>%
  ungroup() %>%
  top_n(50)

png('TedTalks/graph/jess02.png')

ggplot(word_freq, aes(reorder(word,n), n, fill = 10)) + 
  geom_col(show.legend = FALSE) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

dev.off()
###decide to remove the word "Like" from further analysis -- it does not have a sentiment and has almost
###double the frequency of the next most common word
##will also remove the word "right" because the meaning is not obvious out of context