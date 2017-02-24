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

coal_combustion <- SCC[grep("Coal", SCC$Short.Name),]$SCC

CoalSubset <-  subset(NEI, NEI$SCC %in% coal_combustion)

PM25byCoalPerYear <- tapply( CoalSubset$Emissions, CoalSubset$year, FUN=sum)

df <- data.frame(PM25byCoalPerYear)

df$year <- rownames(df)

#ggplot(df, aes(x=year, y=PM25byCoalPerYear, group = 1)) + 
#  geom_point() + 
#  geom_line(colour = "red") + 
#  labs(x = "Year", y = "PM2.5 (tons)", title = "PM2.5 by Coal Combustion")

p <- ggplot(df, aes(x=year, y=PM25byCoalPerYear, group = 1)) + 
  geom_point() + 
  geom_line(colour = "red") +
  labs(x = "Year", y = "PM2.5 (tons)", title = "PM2.5 by Coal Combustion")

print(p)

png("plot4.png")

print(p)

#dev.copy(png, "plot4.png")

dev.off()