setwd("C:/Nata Docs/Data Science/Course 4 - Exploratory Analysis/week4-Case_Study/course_project")
getwd()

dir()

## Load in NEI and SCC data sets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

## Aggregate by Sum the total emission by year
AggByYear <- aggregate(Emissions ~ year, NEI, sum)
head(AggByYear)

png("plot1.png", width = 480, height = 480, units = "px")

barplot(height = (AggByYear$Emission)/10^6,
        names.arg = AggByYear$year, xlab = "Year",
        ylab = "PM2.5 Emission (10^6 Tons)",
        main = "Total PM2.5 Emissions From All US Sources"
)

dev.off()

## According to the plot, total emissions from PM2.5 decreased from 1999 to 2008
