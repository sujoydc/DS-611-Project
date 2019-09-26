# Move these to different file and include here
library(ggplot2)
library(ggalt) # For outline 

options(scipen=999)  # turn-off scientific notation like 1e+48
theme_set(theme_classic())


# Load the dataset
olm <- read.csv('./data/athlete_events_clean.csv', header=T)
# Convert to a data frame 
sportsDF <- as.data.frame(olm)

sports21stDF <- subset(sportsDF, Year >= 2000)

firstHist <- ggplot(sports21stDF, aes(Sex))
firstHist +  geom_bar(aes(fill = sports21stDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Histogram on Male/Female", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")

sports21stMedalDF <- subset(sports21stDF, Medal != 'NA')

medalHist <- ggplot(sports21stMedalDF, aes(Sex))
medalHist +  geom_bar(aes(fill = sports21stMedalDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Histogram on Male/Female", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")

