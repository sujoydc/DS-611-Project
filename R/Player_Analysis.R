library(sqldf)
library(ggplot2) 
library(plyr)


setwd("/Users/gogol/Documents/Utica/DSC-611-Z1/Module8/DS-611-Project")


olympic <- read.csv("./data/athlete_events.csv", header = TRUE)

#1. player younger than 19 years old

#USA male/female players

usa_tot <- sqldf("SELECT year,COUNT(*) olympic FROM olympic WHERE noc ='USA' and Age < 19 and year >1999 group by year order by year")
usa_male <- sqldf("SELECT year,COUNT(*) male FROM olympic  WHERE noc ='USA' and Age < 19 and year >1999 and Sex = 'M' group by year order by year")
usa_female <- sqldf("SELECT year,COUNT(*) female FROM olympic  WHERE noc ='USA' and Age < 19 and year >1999 and Sex ='F'group by year order by year")
year <- sqldf("SELECT distinct year FROM olympic  WHERE year >1999 order by year")


--
#2. Non top 10 Medal winning countries \n-- player under 19 (Summer Olympic)
non_top <- sqldf("SELECT year, COUNT(*) player FROM olympic WHERE noc not in ('CAN','CHN','USA','RUS','EUN','RFA','FRG','GER','GRB','JPN','KOR','ITA','NED','NOR','POR','SWE','SWZ','URS','ESP') and Age < 19 and year in ('2000','2004','2008','2012','2016') group by year order by year")

nontop_g <- ddply(non_top, c("Year", "player"))

ggplot(nontop_g, aes(x=Year, y=player, colour=player)) + geom_line()  + geom_point() +
  xlab('Year') +
  ylab('Player')+ labs(title = "Non top 10 Medal winning countries \n-- player under 19 (Summer Olympic)",
  x = "From 2000 to 2016",
  y = "Player number",
  fill = "blue") + scale_x_continuous("Year", breaks=seq(2000, 2016, 4))


#==================

#3. Line chart - Medal winning second tier countries - Summer olympic player under 19

Summer_2tier <- sqldf("SELECT year,COUNT(*) player FROM olympic WHERE noc in 
('AUS','NED','HUN','BRA','ESP','KEN','JAM','CRO','CUB','NZL','CAN','UZB','KAZ','COL','SUI','IRI','GRE','ARG','DEN','SWE','RSA')
and Age < 19 and year in ('2000','2004','2008','2012','2016') group by year order by year")

sum_pg <- ddply(Summer_2tier, c("Year", "player"))

ggplot(sum_pg, aes(x=Year, y=player, colour=player)) + geom_line()  + geom_point() +
  xlab('Year') +
  ylab('Player')+ labs(title = "Medal winning second tier countries \n -- player under 19 in Olympic event",
  x = "From 2000 to 2016",
  y = "Player",
  fill = "blue") + scale_x_continuous("Year", breaks=seq(2000, 2016, 4))



==============================
#4. Player barchart - Medal winning second tier countries - Summer Olympic player under 19 
#split male/female

Summer_2tier <- sqldf("SELECT year,sex,COUNT(*) player FROM olympic WHERE noc in 
('AUS','NED','HUN','BRA','ESP','KEN','JAM','CRO','CUB','NZL','CAN','UZB','KAZ','COL','SUI','IRI','GRE','ARG','DEN','SWE','RSA')
and Age < 19 and year in ('2000','2004','2008','2012','2016') group by year,sex order by year")

sum_pdf <- as.data.frame(Summer_2tier)
sum_pg2 <- ddply(Summer_2tier, c("Year", "player", "Sex"))

spg2 <-ggplot(sum_pdf, aes(Year, player))
spg2 + geom_bar(stat = "identity", aes(fill = Sex),width=1) +theme_minimal() +
  xlab('Year') +
  ylab('Player')+ labs(title = "Medal winning second tier countries \n-- player under 19 (Summer Olympic)",
  x = "From 2000 to 2016",
  y = "Player number",
  fill = "blue") + scale_x_continuous("Year", breaks=seq(2000, 2016, 4))

------------------------------

#5. Player barchart - Medal winning second tier countries - Winter Olympic player under 19 


#Second tier medal countries - Winter olympic

Winter_2tier <- sqldf("SELECT year,sex, COUNT(*) player FROM olympic WHERE noc in 
('JPN','ITA','OAR','CZE','BLR','CHN','SVK','FIN','GBR','POL','HUN','UKR','AUS','SLO','BEL','NZL','ESP','KAZ','LAT', 'LIE')

and Age < 19 and year in ('2002','2006','2010','2014','2018') group by year,sex order by year");

wdf <- as.data.frame(Winter_2tier)
wpg <- ddply(Winter_2tier, c("Year", "player", "Sex"))


wpg <-ggplot(wpg, aes(Year, player))
wpg +geom_bar(stat = "identity", aes(fill = Sex),width=1) +
 labs(title = "Medal winning second tier countries \n-- player under 19 (Winter Olympic)",
  x = "From 2002 to 2018",
  y = "Player number") + scale_x_continuous("Year", breaks=seq(2002, 2018, 4))

--------------------------
#6. Country barchart - Medal winning second tier countries - Winter olympic

Winter_top10_20 <- sqldf("SELECT year, noc, COUNT(*) player FROM olympic WHERE noc in 
('JPN','ITA','RUS','CZE','BLR','CHN','SVK','FIN','GBR','POL')

and Age < 19 and year in ('2002','2006','2010','2014','2018') group by year,noc order by year");

wdf <- as.data.frame(Winter_top10_20)
#wp2 <- ddply(wdf, c("Year", "player", "NOC"))

wpg <-ggplot(Winter_top10_20, aes(Year, player))
wpg +geom_bar(stat = "identity", aes(fill = NOC),width=1) +
 labs(title = "Medal winning second tier countries \n-- player under 19 (Winter Olympic)",
  x = "From 2002 to 2018",
  y = "Player number") + scale_x_continuous("Year", breaks=seq(2002, 2018, 4))

---------------------------






