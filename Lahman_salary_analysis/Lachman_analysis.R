library(dplyr)
library(tidyr)
library(ggplot2)
library (Lahman)
library(data.table)
# schema: https://github.com/cdalzell/Lahman/blob/master/man/figures/Lahnan-db-diagram.jpg 
print(LahmanData)
salaries = as.data.table(Salaries)

# dane z 2010-2016
salaries <- salaries[yearID >= 2006 & yearID <= 2016]
# nowa tabela zawierajaca tylko trzy kolumny: rok, srednia, maximum
avg_year_salary = salaries[, list(Average=mean(salary), Maximum=max(salary)), by="yearID"]
avg_year_salary
# wizualizacja: x - yearId, y - Average
ggplot(avg_year_salary , aes(x = yearID, y = Average/1e6)) + geom_line() + labs(y = "Średnie zarobki, $M", x = "Rok")

# Rozkłady wynagrodzeń według roku dla wszystkich graczy
ggplot(salaries, aes(x = factor(yearID), y = salary/1e5)) +
  geom_boxplot(fill = "lightgreen", outlier.size = 2.5, shape = 1,  alpha = 0.3) +
  labs(x = "Rok", y = "Zarobki, $100К") +
  coord_flip()



head(Teams)

ggplot(Teams , aes(x=salary, y=h)) + geom_point()





teamSalaries <- Salaries %>%
  group_by(lgID, teamID, yearID) %>%
  summarise(Salary = sum(as.numeric(salary))) %>%
  group_by(yearID, lgID) %>%
  arrange(desc(Salary))

teamSalaries


