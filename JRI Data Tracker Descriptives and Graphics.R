

library(dplyr)
library(plyr)
library(tidyr)
library(reshape)
library(ggplot2)

# Load the car package
library(car)

getwd()

#

#setwd("C:/Users/jerem_000/Documents/Urban")
setwd("D:/Users/JWelshlo/Documents/JRI/data tracker/Text and Data for Comms")

jri <- read.csv("jri_datatracker_2017update.csv")

#Create relative variables, so years relative to the baseline
# use the "ends with" function

table(jri$legislation_yr)

jri$basepri <- jri$prisonpop2010  

#This works to set the value to the 2011 value
jri$basepri <- ifelse(jri$legislation_yr==2011, jri$prisonpop2011, jri$basepri)
jri$basepri <- ifelse(jri$legislation_yr==2012, jri$prisonpop2012, jri$basepri)
jri$basepri <- ifelse(jri$legislation_yr==2013, jri$prisonpop2013, jri$basepri)
jri$basepri <- ifelse(jri$legislation_yr==2014, jri$prisonpop2014, jri$basepri)
jri$basepri <- ifelse(jri$legislation_yr==2015, jri$prisonpop2015, jri$basepri)

### Perhaps it would be better to break the data up then append together
jri2010 <- filter(jri, legislation_yr==2010)
jri2010$pri <- (jri2010$prisonpop2010 / jri2010$prisonpop2010) * 100
jri2010$yr1 <- (jri2010$prisonpop2011 / jri2010$prisonpop2010) * 100
jri2010$yr2 <- (jri2010$prisonpop2012 / jri2010$prisonpop2010) * 100
jri2010$yr3 <- (jri2010$prisonpop2013 / jri2010$prisonpop2010) * 100
jri2010$yr4 <- (jri2010$prisonpop2014 / jri2010$prisonpop2010) * 100
jri2010$yr5 <- (jri2010$prisonpop2015 / jri2010$prisonpop2010) * 100

jri2010 <- select(jri2010, state, pri, yr1, yr2, yr3, yr4, yr5)

#Line graph of change over time.
## Need three variables, one with state, one with year and one with the population
jrilong2 <- melt(jri2010, id=c("state"))

#create a new year variable
jrilong2 <- transform(jrilong2, year = 0)
jrilong2$year <- ifelse(jrilong2$variable == "yr1", 1 , jrilong2$year)
jrilong2$year <- ifelse(jrilong2$variable == "yr2", 2 , jrilong2$year)
jrilong2$year <- ifelse(jrilong2$variable == "yr3", 3 , jrilong2$year)
jrilong2$year <- ifelse(jrilong2$variable == "yr4", 4 , jrilong2$year)
jrilong2$year <- ifelse(jrilong2$variable == "yr5", 5 , jrilong2$year)

source('https://raw.githubusercontent.com/UrbanInstitute/urban_R_theme/temp-windows/urban_ggplot_theme.R')

ggplot(data=jrilong2, aes(x=year, y=value, group=state, color=state)) +
  geom_line(size = 1.5) + 
  scale_y_continuous(limits = c(50, 120))


