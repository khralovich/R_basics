library(dplyr)

hflights

## 1 
hflights %>% 
  filter(Distance / (AirTime/60) > 300) %>% 
  summarise(n_flights = n(),
            n_dest = n_distinct(Dest),
            min_dist = min(Distance, na.rm=TRUE),
            max_dist = max(Distance, na.rm=TRUE))

## 2 
hflights %>%
  filter(Distance > 1000) %>% 
  group_by(UniqueCarrier) %>% 
  summarise(n_flights = n()) %>% 
  arrange(desc(n_flights))


hflights %>%
  filter(Distance > 1000) %>% 
  group_by(UniqueCarrier) %>% 
  summarise(n_flights = sum(Distance > 1000)) %>% 
  arrange(desc(n_flights))



# 3
hflights %>% 
  group_by(UniqueCarrier, Dest) %>% 
  summarise(n_flights = n()) %>%
  filter(n_flights == max(n_flights)) %>%
  ungroup()