require(dplyr)
require(ggplot2)

#--------------------------------------------------
# Users analysis
#--------------------------------------------------

users.activity <- read.csv("users_report.csv")

summary(users.activity)

summary(is.na(users.activity$count))

filter(users.activity, is.na(count) == TRUE)

ggplot(users.activity, aes(timestamp,count, color = status)) + geom_line()


#--------------------------------------------------
# Channels analysis
#--------------------------------------------------

channels.activity <- read.csv("channels_report.csv")

ggplot(filter(channels.activity, channel == "total"), aes(timestamp,count)) + geom_line()
