library(tidyr)
library(ggplot2)
library(dplyr)


head(mtcars)

# 1 

ggplot(mtcars, aes(x=wt, y = mpg, col = factor(cyl))) + 
  geom_point(shape = 1, size = 4.5, alpha = 0.6) + facet_grid(factor(am)~.)


# 2 

mtcars$name <- rownames(mtcars)
head(mtcars)

ggplot(mtcars, aes(x=hp, y=carb, label=name)) + 
  geom_text(alpha = 0.6, check_overlap = TRUE) + 
  ggtitle("Nazwy samochodów") + 
  theme(plot.title = element_text(hjust = 0.5))