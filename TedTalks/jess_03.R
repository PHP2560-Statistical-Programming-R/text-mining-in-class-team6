#######what are the most common sentiments within ted talks grouped by their most popular rating#########
load("TedTalks/data/sentiments_nrc.Rda")

sentiment_plot <- sentiments_nrc %>%
  filter(!word %in% c("like", "right")) %>%
  filter(!sentiment %in% c("positive", "negative")) %>%
  count(max_rating, sentiment) %>%
  group_by(max_rating) %>%
  mutate(sentiment_count = sum(n)) %>%
  ungroup() %>%
  mutate(prop = n/ sentiment_count)

png('TedTalks/graph/jess03.png')

ggplot(sentiment_plot, aes(sentiment, prop, fill = max_rating)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~max_rating, scales = "free", labeller = ) +
  coord_flip() + 
  ylab("") + 
  xlab("Sentiment") +
  ggtitle("Distribution of Sentiments of Words used in Ted Talks by Rating")

dev.off()