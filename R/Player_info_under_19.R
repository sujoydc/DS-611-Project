install.packages("sqldf")
library(sqldf)
require(ggplot2) 
library(plyr)


#setwd ("C:/DS/09 Visualization/week8/data")
setwd("/Users/gogol/Documents/Utica/DSC-611-Z1/Module8/DS-611-Project")

a <- read.csv("athlete_events.csv", header = TRUE)

# 1. all player younger than 19 years old

p1 <- sqldf("SELECT year,COUNT(*) player FROM a WHERE noc ='USA' and Age < 19 and year >1999 group by year order by year")
p2 <- sqldf("SELECT COUNT(*) male FROM a WHERE noc ='USA' and Age < 19 and year >1999 and Sex = 'M' group by year order by year")
p3 <- sqldf("SELECT year,COUNT(*) female FROM a WHERE noc ='USA' and Age < 19 and year >1999 and Sex ='F'group by year order by year")
year <- sqldf("SELECT distinct year FROM a WHERE year >1999 order by year")

--
#working plot for USA

tg <- ddply(a, c("sex", "number"))
year=a$year
palyer=a$number
sex=a$sex
ggplot(tg, aes(x=year, y=number, colour=sex)) + geom_line()  + geom_point() +
xlab('Year') +
 ylab('Player')+ labs(title = "USA player under 19 in Olympic event",
        x = "From 2000 to 2016",
        y = "Player",
        fill = "blue") 
-------------------------------

w1 <- sqldf("SELECT year,COUNT(*) player FROM a WHERE Age < 19 and year >1999 group by year order by year")
w2 <- sqldf("SELECT COUNT(*) male FROM a WHERE Age < 19 and year >1999 and Sex = 'M' group by year order by year")
w3 <- sqldf("SELECT year,COUNT(*) female FROM a WHERE Age < 19 and year >1999 and Sex ='F'group by year order by year")
year <- sqldf("SELECT distinct year FROM a WHERE year >1999 order by year")

w <- read.csv("world_player.csv", header = TRUE)

wp <- ddply(w, c("sex", "number"))
year=w$year
palyer=w$number
sex=w$sex

ggplot(wp, aes(x=year, y=number, colour=sex)) + geom_line()  + geom_point() +
xlab('Year') +
 ylab('Player')+ labs(title = "Player under 19 in Olympic events",
        x = "From 2000 to 2016",
        y = "Player number",
        fill = "blue") 


==================

all players:

a <- read.csv("athlete_events.csv", header = TRUE)

a1 <- sqldf("SELECT year,COUNT(*) player FROM a WHERE year >1999 group by year order by year")
a2 <- sqldf("SELECT COUNT(*) male FROM a WHERE year >1999 and Sex = 'M' group by year order by year")
a3 <- sqldf("SELECT year,COUNT(*) female FROM a WHERE year >1999 and Sex ='F'group by year order by year")
year <- sqldf("SELECT distinct year FROM a WHERE year >1999 order by year")

all <- read.csv("all_player.csv", header = TRUE)

allp <- ddply(all, c("sex", "number"))
year=all$year
palyer=all$number
sex=all$sex

ggplot(allp, aes(x=year, y=number, colour=sex)) + geom_line()  + geom_point() +
xlab('Year') +
 ylab('Player')+ labs(title = "Total player in Olympic events",
        x = "From 2000 to 2016",
        y = "Player number",
        fill = "blue") 


