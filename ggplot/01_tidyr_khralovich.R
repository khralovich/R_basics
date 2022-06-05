library(tidyr)
library(readr)

bmi <- read.csv("https://raw.githubusercontent.com/amachno/R_course_UJ_ed1/master/bmi_clean.csv")
head(bmi)
view(bmi)

data_long <- gather(data=bmi, key=year, value=bmi_value, -Country)
data_wide <- spread(data=data_long, key=year,  value=bmi_value)
# Y1981 -> 1981
data_long$year <- substr(data_long$year, 2, 5)


students <- read.csv("https://raw.githubusercontent.com/amachno/R_course_UJ_ed1/master/students_with_dates.csv")
head(students)
# separate 1 col into 3 cols
grades_sep <- separate(data=students, col=Grades, c("1", "2", "3"), convert=T)


data_long
data_wide
grades_sep 