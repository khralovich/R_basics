library (Lahman)
library (dplyr)

# schema: https://github.com/cdalzell/Lahman/blob/master/man/figures/Lahnan-db-diagram.jpg 

print(LahmanData)
head(Appearances)
head(Salaries)
head(HallOfFame)

# 1 

salary_total <- People %>%
  left_join(Salaries)

select(salary_total, playerID, salary)


no_salary <- People %>%
  anti_join(Salaries)

no_salary_clean <- select(no_salary, playerID)
no_salary_clean


# 2 

no_salary_appear <- no_salary_clean %>%
  left_join(Appearances) %>% 
  group_by(playerID) %>%
  summarise(G_all = sum(G_all, na.rm = T)) %>%
  summarise(min_games = sum(G_all ==0),
            max_games = max(G_all),
            avg_gamex = mean(G_all))

  

head(no_salary_appear)


# 3 

?HallOfFame

new_hall <- HallOfFame %>% 
  arrange(playerID, inducted) %>% 
  group_by(playerID) %>%
  summarise(inducted = last(inducted))


new_hall

Salaries %>% 
  left_join(new_hall) %>%
  group_by(inducted)%>% 
  summarise(avg_sal = mean(salary),
            q1_sal = quantile(salary, 0.25),
            median_sal = median(salary),
            q3_sal = quantile(salary, 0.75))



