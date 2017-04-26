## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 
## 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question

## Load in NEI and SCC data sets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

## Loading required package ggplot2

library(ggplot2)

## Subset data only for Baltimore

BaltimoreData <- NEI[NEI$fips == "24510",]
head(BaltimoreData)

## Aggregate by Sum the total emission by year
AggByYear_Baltimore <- aggregate(Emissions ~ year + type, BaltimoreData, sum)
head(AggByYear_Baltimore)

png("plot3.png", width = 680, height = 480, units = "px")

g <- ggplot(AggByYear_Baltimore, aes(factor(year), Emissions, fill = type))
g <- g + geom_bar(stat = "identity") + 
        theme_bw() + guides(fill=FALSE) + 
        facet_grid(. ~ type) + xlab("year") + 
        ylab(expression('Total PM' [2.5]*" Emissions")) +
        ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
g

dev.off()

## According to the plot, the first 3 sources (non-road, non-point and on-road)
## have seen decreases in emissions from 1999 - 2008 for Baltimor City.
## The last one "POINT" increased in emissions from 1999 - 2008.

