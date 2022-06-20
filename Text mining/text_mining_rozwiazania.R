library(readr)
library(dplyr)
library(tidyr)
library(tidytext)
library(stringr)
library(ggplot2)
library(scales)
library(reshape2)
library(RColorBrewer)
library(wordcloud)

data <- read_csv('/home/nasta/Documents/AGH - Statystyczna analiza danych/R/R Advanced (Machno)/Text mining/wine.csv')

text_df <- data %>%
  select(X1, description) %>%
  unnest_tokens(word, description)

my_stop_words <-
  rbind(stop_words, 
        tibble(word = c("wine", "flavors", "aromas", "palate"),
               lexicon = "my"))

text_df <- 
  text_df %>% anti_join(my_stop_words)

data <- data %>%
  mutate(country = ifelse(country %in% c("US", "France", "Italy"), 
                          country, 
                          "other")) %>%
  mutate(country = factor(country, levels = c("US", "France", "Italy", "other")))

text_df %>%
  left_join(data %>% select(X1, country)) %>%
  count(country, word, sort = T) %>%
  semi_join(text_df %>% 
              count(word) %>%
              filter(n > 20000),
            by = "word") %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n, fill = country)) +
  geom_col(position = "fill") + 
  xlab(NULL) +
  coord_flip()

frequency <- text_df %>%
  left_join(data %>% select(X1, country)) %>%
  count(country, word) %>% 
  filter(n > 10) %>%
  group_by(country) %>%
  mutate(proportion = n / sum(n)) %>%
  select(-n) %>%
  spread(key = country, value = proportion, fill = 0) %>%
  gather(country, frequency, France:other)

ggplot(frequency, aes(x = frequency, 
                      y = US, 
                      col = abs(frequency - US))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = T, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) + 
  scale_y_log10(labels = percent_format()) + 
  scale_color_gradient(limits = c(0, 0.001), 
                       low = "darkslategray4",
                       high = "gray70") +
  theme(legend.position = "none") + 
  facet_wrap(~country)


##############################

bing <- get_sentiments("bing")
sentiment_df <- 
  text_df %>% 
  left_join(bing) %>%
  group_by(X1) %>%
  summarise(pos = sum(sentiment == "positive", na.rm = T),
            neg = sum(sentiment == "negative", na.rm = T),
            n = n())

data %>% left_join(sentiment_df, by = "X1") %>%
  mutate(polarity = (pos - neg) / n) %>%
  ggplot(aes(y = polarity, x = country)) +
  geom_boxplot()

data %>%
  select(X1, description, country) %>%
  unnest_tokens(word, description) %>%
  inner_join(bing) %>%
  count(word, sentiment, country, sort = TRUE) %>%
  ungroup() %>%
  group_by(sentiment, country) %>%
  top_n(5) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~country, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

data %>%
  select(X1, description, country) %>%
  unnest_tokens(word, description) %>%
  inner_join(bing) %>%
  count(word, country, sort = TRUE) %>%
  acast(word ~ country, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "blue", "green", "gray"),
                   max.words = 100)

nrc <- get_sentiments("nrc")

nrc_df <- 
  text_df %>% 
  left_join(nrc %>% 
              filter(!(sentiment %in% c("positive", "negative")))) %>%
  group_by(X1, sentiment) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  spread(key = sentiment, value = n, fill = 0) %>% 
  select(X1:trust) 

data %>% left_join(nrc_df, by = "X1") %>% 
  gather(key = "sentiment", 
         value = "n_sentiment", 
         anger:trust) %>%
  ggplot(aes(y = n_sentiment, 
             x = sentiment, 
             col = country)) +
  geom_boxplot(outlier.alpha = 0.1) +
  labs(y = "number", x = NULL) +
  coord_flip()
