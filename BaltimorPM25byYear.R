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

#library(dplyr)
#library(ggplot2)


BaltimorSubset <-  subset(NEI, NEI$fips == "24510")
BaltimorPM25byYear <- tapply( BaltimorSubset$Emissions, BaltimorSubset$year, FUN=sum)

#barplot(PM25byYear/1000 , col = 10, xlab="Years", main = "PM2.5 10^3 tons per Year")
plot(c(1999, 2002, 2005,2008), 
     BaltimorPM25byYear/1000, 
     type = "l", 
     col = "red", 
     main = "Baltimor PM2.5 10^3 tons per Year", 
     ylab = "PM2.5", xlab = "Year")

dev.copy(png, "BaltimorPM25byYear.png")

dev.off()