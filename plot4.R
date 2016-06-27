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

### Question 4
#Accross the United States, how have emissions from coal combustion-related sources
#changed from 1999-2008?

# Check out the data to understand which variable contains 'coal' cases
str(SCC)
levels(SCC$EI.Sector)

# Load required packages
library(dplyr)
library(ggplot2)

# Create a new data set by:
## Selecting variables of interest from SCC data set
## selecting only the 'Coal' cases, 
## merging the two datasets (NEI and SCC) 
## and group data by code sources (SCC) and year to get the summary of PM2.5 emissions

tot.Coal <- SCC %>%
        select(SCC, EI.Sector) %>%
        mutate(Sector_Coal = as.character(EI.Sector)) %>% 
        filter(grepl("Coal", Sector_Coal)) %>%
        mutate(SCC = as.character(SCC)) %>%
        inner_join(NEI, by="SCC") %>%
        group_by(year) %>%
        summarise(
                Emissions = sum(Emissions)
        ) 

# Plot the evolution from total coal combustion sources, by year, across all the United states

png("plot4.png", width = 480, height = 480)
ggplot(tot.Coal, aes(year, Emissions)) + theme_light() + 
        geom_point() + geom_line() + 
        labs(title = "PM2.5 emissions from Coal Combustion Sources", 
             y = "PM2.5 emissions (ton)", x = "Years")

dev.off()

# Comment: PM2.5 total emissions are much lower in 2008 when compared to the previous years. 
