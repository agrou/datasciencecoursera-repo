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

### Question 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Check out data to understand which are motor vehicles
summary(SCC$SCC.Level.Three)
str(SCC$SCC.Level.Three)

# Load required packages
library(dplyr)
library(ggplot2)

# Select motor vehicles from the data set 'SCC' and join this data with 
# Baltimore city cases data set

## Motor vehicles where selected from variable "SCC.Level.Three"
### Three levels were considered: Motorcycles, Motor Vehicles and Motor Vehicle Fires

BCity <- NEI[NEI$fips == "24510",]

BCity_tot_Motor <- BCity %>%
        select(fips, year, Emissions, type) %>%
        filter(grepl("ON-ROAD", type)) %>%
        group_by(fips, year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

summary(BCity_tot_Motor)

# Plot PM2.5 emissions from every motor vehicle source, in Baltimore city 
png("plot5.png", width = 480, height = 480)
BMotor_plot <- ggplot(BCity_tot_Motor, aes(year, Emissions)) 
BMotor_plot + theme_bw() + geom_point() + geom_line() + 
        labs(title = "PM2.5 emissions from Motor Vehicles in Baltimore City", 
             y = "PM2.5 emissions (ton)", x = "Years") 
dev.off()

# Comment: There seems to be an overall decrease in total PM2.5 emissions 
# of motor vehicles, from 1999 to 2008, with some stability in polution levels in 2002 and 2005