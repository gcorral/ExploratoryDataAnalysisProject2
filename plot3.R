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


BaltimorSubset <-  subset(NEI, NEI$fips == "24510")

BaltimorSubsetSum <- with(BaltimorSubset, tapply(Emissions, list(year, type), FUN=sum))

df <- data.frame(BaltimorSubsetSum)

df$year <- rownames(df)

dfm <- melt(df, id=c("year"), measure.vars=c("NON.ROAD","NONPOINT","ON.ROAD","POINT"))

ggplot(dfm, aes(x=year, y=value, color=variable, group = variable)) + 
  geom_point() + 
  geom_line() + 
  labs(x = "Year", y = "PM2.5 (tons)", title = "PM2.5 Baltimore per Year")


dev.copy(png, "plot3.png")

dev.off()