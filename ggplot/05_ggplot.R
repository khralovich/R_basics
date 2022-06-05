library(ggplot2)


head(diamonds)

# 1 

ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point() 


# 2 

ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point() + geom_smooth(method = "lm")


# 3 

ggplot(diamonds, aes(x=carat, y=price, color = clarity)) +
  geom_point() + geom_smooth()


# 4 

ggplot(diamonds, aes(x=carat, y=price, color = clarity)) +
  geom_point(aes=(shape=cut)) + geom_smooth(se=F)