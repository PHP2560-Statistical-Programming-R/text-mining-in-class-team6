
### what is the distribution of ratings given to ted talks ###


rating_dist <- transcripts_clean %>%
  distinct(name, max_rating) %>%
  group_by(max_rating) %>%
  count()



ggplot(rating_dist, aes(reorder(max_rating, n), n, fill = max_rating)) +
  geom_col(show.legend = FALSE) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  xlab("Max Rating") + 
  ylab("Count") +
  ggtitle("Distribution of Max Ratings given to all Ted Talks")
