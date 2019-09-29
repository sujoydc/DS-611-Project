#install.packages("countrycode")
#install.packages("rworldmap")

# Move these to different file and include here
library(ggplot2)
library(ggalt) # For outline 

options(scipen=999)  # turn-off scientific notation like 1e+48
theme_set(theme_classic())

setwd("/Users/gogol/Documents/Utica/DSC-611-Z1/Module8/DS-611-Project")

# Load the dataset
olm <- read.csv('./data/athlete_events_clean.csv', header=T)
# Convert to a data frame 
sportsDF <- as.data.frame(olm)

# Our analysis is only for 21st Century
sports21stDF <- subset(sportsDF, Year >= 2000)

# Medal (including non winners) count for Male/Female  
firstHist <- ggplot(sports21stDF, aes(Sex))
firstHist +  geom_bar(aes(fill = sports21stDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Male/Female Distribution", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")

# Subset of only medal winners
sports21stMedalDF <- subset(sports21stDF, Medal != 'NA')

# Medal count for Male/Female  
medalHist <- ggplot(sports21stMedalDF, aes(Sex))
medalHist +  geom_bar(aes(fill = sports21stMedalDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Histogram on Male/Female", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")

# Create an age group category 
sports21stMedalDF$AgeGroup <- ifelse(sports21stMedalDF$Age <=18, "High School",
                              ifelse(sports21stMedalDF$Age > 18 & sports21stMedalDF$Age <= 22, "Under Grad", "Adult"))

# Medal count on Age group
ageHist <- ggplot(sports21stMedalDF, aes(AgeGroup))
ageHist +  geom_bar(aes(fill = sports21stMedalDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Histogram on Age Group", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")


# Location with number of participant
library(countrycode)

sportsDF$continent <- countrycode(sourcevar = sportsDF[, "Team"],
                            origin = "country.name",
                            destination = "continent")

continentHist <- ggplot(sports21stMedalDF, aes(continent))
continentHist +  geom_bar(aes(fill = sports21stMedalDF$Medal), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title = "Medal Per Continents", 
       y = "Count",
       fill = "# Medals",
       caption = "Olympics Data Visualization")

# World map 
library(rworldmap)

#create a map-shaped window
mapDevice('x11')

# Create a medal count with groupby Team which is Country 
medalPerCountry <- table(sports21stMedalDF$Team)

medalCountryDF <- data.frame(medalPerCountry)
#join to a coarse resolution map
spdf <- joinCountryData2Map(ddf, joinCode="NAME", nameJoinColumn="country")

mapCountryData(spdf, nameColumnToPlot="value", catMethod="fixedWidth")
