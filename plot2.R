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

### Question 2 
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008?

## Select only the cases that correspond to Baltimore City
BCity <- NEI[NEI$fips == 24510,]

## Create a dataset with the total PM2.5 emissions by year, in Baltimore City
BCity_tot <- BCity %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

years <- BCity_tot$year
emissions <- BCity_tot$Emissions

# Plot PM2.5 emissions in Baltimore City, along the years

png("plot2.png", width = 480, height = 480)
par(mar = c(6, 5, 5, 2))
plot(years, emissions, main = "Total PM2.5 emissions in Baltimore City, Maryland", 
     xlab = "Years", ylab = "PM2.5 Emissions (ton)", pch = 1, col = 3, lwd = 3)
dev.off()

# Comment: There seems to be an increase in PM2.5 emissions in 2005, 
# compared to 2002 and 2008