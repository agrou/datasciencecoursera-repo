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

### QUESTION 1
# Make a plot with base plotting system showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, 2008
# Loading required libraries
library(dplyr)

# Select the required columns and determine the total PM2.5 emissions by year
NEI_tot <- NEI %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

years <- NEI_tot$year
emissions <- NEI_tot$Emissions

# Plot the evolution of total PM2.5 emissions along the years (using base graphics)

# Plot 1
png("plot1.png", width = 480, height = 480)
par(mar = c(6, 5, 5, 2))
plot(years, emissions, main = "Total PM2.5 emissions along the years", 
     xlab = "Years", ylab = "PM2.5 Emissions (ton)", pch = 8, col = 4)
dev.off()
