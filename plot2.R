## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008?

## Load in NEI and SCC data sets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

## Subset data only for Baltimore

BaltimoreData <- subset(NEI, fips == "24510")
##head(BaltimoreData)

## Aggregate by Sum the total emission by year
AggByYear_Baltimore <- aggregate(Emissions ~ year, BaltimoreData, sum)
head(AggByYear_Baltimore)

png("plot2.png", width = 480, height = 480, units = "px")

barplot(height = AggByYear_Baltimore$Emission,
        names.arg = AggByYear_Baltimore$year, xlab = "Year",
        ylab = "PM2.5 Emission",
        main = "Total PM2.5 Emissions in the Baltimore City"
)

dev.off()

## According to the plot, total emissions from PM2.5 in the Baltimore City 
## decreased from 1999 to 2008. 
