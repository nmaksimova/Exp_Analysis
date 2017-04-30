## How have emissions from motor vehicle sources changed from 1999–2008 
## in Baltimore City?

## Load in NEI and SCC data sets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge the 2 datasets together

NEI_SCC <- merge(NEI, SCC, by = "SCC")

## Loading required package ggplot2

library(ggplot2)

## Identify all NEI_SCC records with Short.Name containing "vehicle"

MotorVehicleRelated <- grepl("vehicle", NEI_SCC$SCC.Level.Two, ignore.case = TRUE)
selected_MotorVehicle_rows <- NEI_SCC[MotorVehicleRelated, ]

## Subset data only for Baltimore
 BaltimoreData <- selected_MotorVehicle_rows[selected_MotorVehicle_rows$fips == "24510",]
 head(BaltimoreData)

## Aggregate by Sum the total emission by year
AggByYear <- aggregate(Emissions ~ year, BaltimoreData, sum)
head(AggByYear)

png("plot5.png", width = 680, height = 480, units = "px")

g <- ggplot(AggByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + 
        theme_bw() + guides(fill=FALSE) + 
        xlab("year") + 
        ylab(expression('Total PM' [2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
g

dev.off()



