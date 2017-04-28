## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

## Load in NEI and SCC data sets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge the 2 datasets together

NEI_SCC <- merge(NEI, SCC, by = "SCC")

## Loading required package ggplot2

library(ggplot2)

## Identify all NEI_SCC records with Short.Name containing "coal"

coalRelated <- grepl("coal", NEI_SCC$Short.Name, ignore.case = TRUE)
selected_coalRelated_rows <- NEI_SCC[coalRelated, ]
head(selected_coalRelated_rows)

## Subset data only for Baltimore
## BaltimoreData <- NEI[NEI$fips == "24510",]
## head(BaltimoreData)

## Aggregate by Sum the total emission by year
AggByYear <- aggregate(Emissions ~ year, selected_coalRelated_rows, sum)
head(AggByYear)

png("plot4.png", width = 680, height = 480, units = "px")

g <- ggplot(AggByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + 
        theme_bw() + guides(fill=FALSE) + 
        xlab("year") + 
        ylab(expression('Total PM' [2.5]*" Emissions")) +
        ggtitle('Total Emissions from coal sources from 1999 to 2008')
g

dev.off()



