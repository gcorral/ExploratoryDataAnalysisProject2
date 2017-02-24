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
library(reshape2)

vehicle <- SCC[grep("Vehicle", SCC$Short.Name, ignore.case = TRUE),]$SCC

fips_filter <- c("24510", "06037")

VinBalLASubset <-  subset(NEI, NEI$SCC %in% vehicle & NEI$fips %in% fips_filter)

VinBalLASubsetSum <- with(VinBalLASubset, tapply(Emissions, list(year, fips), FUN=sum))

df <- data.frame(VinBalLASubsetSum)

df$year <- rownames(df)

colnames(df) <- c("LA", "Baltimor", "year") 

dfm <- melt(df, id=c("year"), measure.vars=c("LA","Baltimor"))

#p <- ggplot(dfm, aes(x=year, y=value, color=variable, group = variable)) + 
#  geom_point() +
#  geom_boxplot() + 
#  geom_line() + 
#  labs(x = "Year", y = "PM2.5 (tons)", title = "PM2.5 Emission by vehicles")

p <- ggplot(dfm, aes(x=variable, y=value)) + 
  geom_boxplot() + 
  labs(x = "Cities", y = "PM2.5 (tons)", title = "Emissions evolution 1999 - 2008")

print(p)

png("plot6.png")

print(p)

dev.off()
