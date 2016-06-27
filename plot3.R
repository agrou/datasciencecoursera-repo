# Exploratory Data Analysis Course Project 2 
# Fine particulate matter (PM2.5): Data from 1999, 2002, 2005 and 2008

# Data source:
zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Add files to the working directory if they don't already exist and download them
dir <- getwd()
if(!file.exists(dir)){dir.create("./EDA_CourseProject2")}
download.file(zipfile, "dir", method = "curl")
if(!file.exists("summarySCC_PM25.rds")){unzip("dir", "summarySCC_PM25.rds")}
if(!file.exists("Source_Classification_Code.rds")){unzip("dir", "Source_Classification_Code.rds")}

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Exploratory Data Analysis for the assignment's questions:

### Question 3
# Which of the four sources have seen decreases in emissions from 
# 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008?

## Select only the cases that correspond to Baltimore City
BCity <- NEI[NEI$fips == 24510,]

# Check out which are the four sources 'type' of PM2.5 emissions
str(BCity)
unique(BCity$type)

#Load required package
library(ggplot2)

# Create a new data set with total emissions of PM2.5 by each type of sources and per year
BCity_type <- BCity %>%
        select(type, year, Emissions) %>%
        group_by(type, year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

years <- BCity_type$year
emissions <- BCity_type$Emissions
type <-  as.factor(BCity_type$type)

# Plot the evolution of PM2.5 emissions per year, in 4 different windows (one for each type of source)
png("plot3.png", width = 480, height = 480)
qplot(years, emissions, facets = .~type, ylab = "PM2.5 Emissions", 
      main = "PM2.5 Emissions in the 4 sources of Baltimore City", geom = "line")
dev.off()

# Comment: All the 4 sources of Baltimore City seem to have decreases 
# in PM2.5 emissions along the years, except source type 'Point', with increases 
# in 2002 and 2005