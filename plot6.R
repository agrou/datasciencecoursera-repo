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

### Question 6
## Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California(fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Selecting LA and Baltimore city corresponding rows in the data set
LACity <- NEI[NEI$fips == "06037",]

BCity <- NEI[NEI$fips == "24510",]

# Load required packages
library(dplyr)
library(ggplot2)

# Subsetting the data in two data sets creating a new one with only motor vehicles 
# PM2.5 emissions

# Data for Baltimore City

BCity_tot_Motor <- BCity %>%
        select(fips, year, Emissions, type) %>%
        filter(grepl("ON-ROAD", type)) %>%
        group_by(fips, year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

# Data for LA city

LACity_tot_Motor <- LACity %>%
        select(fips, year, Emissions, type) %>%
        filter(grepl("ON-ROAD", type)) %>%
        group_by(fips, year) %>%
        summarise(
                Emissions = sum(Emissions)
        )

# Binding the two data sets by row to plot the data side by side
#Cities_Motors <- rbind(BCity.Motor, LA.Motor)
Cities_Motors <- rbind(BCity_tot_Motor, LACity_tot_Motor)
str(Cities_Motors)

# Converting 'fips' variable into factor to attribute a name to it's levels
Cities_Motors$fips <- factor(Cities_Motors$fips)
levels(Cities_Motors$fips) <- c("LA City", "Baltimore City")

# Creating the plot for the two cities (LA and Baltimore)
png("plot6.png", width = 480, height = 480)

CitiesMotors_plot <- ggplot(Cities_Motors, aes(year, Emissions))

# Plotting LA city and Baltimore emissions in two different plots 
CitiesMotors_plot + theme_bw() + geom_point() + geom_line() + 
        facet_grid(fips ~ .) + 
        theme(strip.text.y = element_text(size = 10, face = "bold")) + 
        labs(title = "PM2.5 emissions from Motor Vehicles in two cities", 
             y = "PM2.5 emissions (ton)", x = "Years") 
        
dev.off()

# Comment: Baltimore City total PM2.5 emissions are much lower than in LA city, 
# and there seems to be a decrease along the years in Baltimore City. LA city total PM2.5
# levels have increased along the years but seem to have decreased in 2008.