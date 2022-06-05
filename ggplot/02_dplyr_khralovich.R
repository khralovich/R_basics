library(dplyr)
library(hflights)

## 1 
delayDf <- select(hflights, Year, Month, DayofMonth, ArrDelay, DepDelay)
delayDf


## 2
moreThanHour <- filter(hflights, ArrDelay > 60, DepDelay > 60)
moreThanHour

## 3 
taxiInOut = hflights$TaxiIn + hflights$TaxiOut
summarise(hflights, 
          min_taxi=min(taxiInOut, na.rm = TRUE), 
          max_taxi=min(taxiInOut, na.rm = TRUE), 
          avg_taxi = mean(taxiInOut, na.rm=TRUE), 
          median_taxi = median(taxiInOut, 
          na.rm = TRUE), prop_taxi = (is.na(taxiInOut)) )
