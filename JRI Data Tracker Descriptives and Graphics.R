
# JRI data tracker descriptives

library(dplyr)
library(plyr)
library(tidyr)
# Install the car package
install.packages("car")

# Load the car package
library(car)

getwd()

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
jri2010$pri_base <- jri2010$prisonpop2010
jri2010$yr1_base <- jri2010$prisonpop2011
jri2010$yr2_base <- jri2010$prisonpop2012
jri2010$yr3_base <- jri2010$prisonpop2013
jri2010$yr4_base <- jri2010$prisonpop2014
jri2010$yr5_base <- jri2010$prisonpop2015

jri2010 <- select(jri2010, state, pri_base, yr1_base, yr2_base, yr3_base, yr4_base, yr5_base)

#Line graph of change over time.
## Need three variables, one with state, one with year and one with the population
jrilong <- gather(jri2010, state, population, pri_base-yr5_base )



