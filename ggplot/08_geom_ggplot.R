library(ggplot2)
library(tidyr)
library(dplyr)


head(hflights)


## 1
hflights %>% 
  gather(DelayType, Delay, ArrDelay, DepDelay) %>%
  ggplot (aes(x = Delay, fill = DelayType)) + 
  geom_histogram(bandwith =1, position = "dodge")



# 2 

hflights %>% 
  gather(TaxiType, Taxi, TaxiIn, TaxiOut) %>%
  ggplot (aes(x = Taxi, fill = TaxiType)) + 
  geom_histogram(bandwith =1, position = "stack")
