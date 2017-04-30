## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

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

## Subset data for Baltimore City and Los Angeles County
 BaltimoreData <- selected_MotorVehicle_rows[selected_MotorVehicle_rows$fips == "24510",]
 BaltimoreData$city <- "Baltimore City"
 
 LAData <- selected_MotorVehicle_rows[selected_MotorVehicle_rows$fips == "06037",]
 LAData$city <- "Los Angeles County"
 
 #Conbine the two data sets by city
 BothCityData <- rbind(BaltimoreData, LAData)

png("plot6.png", width = 680, height = 480, units = "px")

g <- ggplot(BothCityData, aes(factor(year), Emissions, fill = city))
g <- g + geom_bar(aes(fill = year), stat = "identity") + 
        facet_grid(.~city, scales = "free", space = "free") +
        theme_bw() + guides(fill=FALSE) + 
        xlab("year") + 
        ylab(expression('Total PM' [2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland (fips = "24510") and LA County (fips = "06037") from 1999 to 2008')

g

dev.off()



