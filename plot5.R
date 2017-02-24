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

vehicle <- SCC[grep("Vehicle", SCC$Short.Name, ignore.case = TRUE),]$SCC

VinBaltimorSubset <-  subset(NEI, NEI$SCC %in% vehicle & NEI$fips == "24510")

VinBaltimorSubsetSum <- with(VinBaltimorSubset, tapply(Emissions, year, FUN=sum))

df <- data.frame(VinBaltimorSubsetSum)

df$year <- rownames(df)

p <- ggplot(df, aes(x=year, y=VinBaltimorSubsetSum, group = 1)) + 
  geom_point() + 
  geom_line(colour = "red") + 
  labs(x = "Year", y = "PM2.5 (tons)", title = "Baltimor PM2.5 emission by vehicles")

print(p)

png("plot5.png")

print(p)

dev.off()
