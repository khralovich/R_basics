library(tidyr)
library(ggplot2)
library(dplyr)
library(hflights)


head(hflights)


# 1 
hflights %>% 
  gather(delayType, delay, ArrDelay, DepDelay) %>%
  ggplot (aes(y = delay, x = AirTime, shape = delayType, size = Distance, color = UniqueCarrier)) + 
  geom_point()


# 2 

hflights %>% 
  gather(delayType, delay, ArrDelay, DepDelay) %>%
  ggplot (aes(y = delay, x = AirTime, shape = delayType, size = Distance, color = UniqueCarrier)) + 
  geom_point(alpha = 0.1) +
  facet_wrap(.~UniqueCarrier, ncol = 3)


# 3 

hflights %>% 
  gather(TaxiType, Taxi, TaxiIn, TaxiOut) %>%
  unite(date, Year:DayofMonth, sep="-") %>% 
  mutate(date = as.Date(date)) %>% glimpse %>%
  ggplot (aes(y = Taxi, x = date)) + 
  geom_point(aes(shape = TaxiType, size = Distance)) +
  geom_smooth(aes(col = UniqueCarrier), se = F)