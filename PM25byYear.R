
#
#  Download data zip file for Peer Assessment 
#  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./ExdataFNEI.zip")
#
#  ExdataFNEI.zip:
#
#  summarySCC_PM25.rds
#  Source_Classification_Code.rds
#
#  Read files:
#
#  NEI <- readRDS("summarySCC_PM25.rds")
#  SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)


PM25byYear <- tapply(NEI$Emissions, NEI$year, FUN=sum)

barplot(PM25byYear/1000 , col = 10, xlab="Years", main = "PM2.5 10^3 tons per Year")

dev.copy(png, "PM25byYear.png")

dev.off()