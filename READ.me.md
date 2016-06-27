# Exploratory Data Analysis - Project Assignment 2
#### Author: Andreia Carlos
#### Date: 21-06-2016
***
### Fine particulate matter (PM2.5) data  
**EPA National Emissions website**: http://www.epa.gov/ttn/chief/eiinformation.html

### Documents in the zip file:
* *summarySCC_PM25.rds* contains a data frame with all the PM2.5 emissions for 1999, 2002, 2005 and 2008.
* *Source_Classification_code.rds* includes a table with the actual names of the PM2.5 sources

### Data variables: 
* fips: five-digit number indicating the U.S. county 
* SCC: source name 
* Pollutant: indicating the pollutant 
* Emissions: tons of PM2.5
* type: type of source (point, non-point, on-road, non-road)
* year: the year when the emissions where recorded

### Files 
* ```EDA_code.R``` includes all the code for this assignment

### Assignment goal
Explore the National Emissions Inventory database and see what is says about PM2.5 in the US over the 10y period 1999-2008. 

### Assignment questions
For each question/task there should be a single plot

1. Have total emissions from PM2.5 decreased in the US from 1998 to 2008? 

        Using the base plotting system, make a plot showing the total PM2.5 emission   from all sources for each of the years 1999, 2002, 2005, 2008
        
2. Have total emissions from PM2.5 decreased in the Baltimore City, 
Maryland (fips == "24510") from 1999 to 2008? 

        Use the base plotting system to make a plot answering this question
        
3. Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) 
variable, which of these four sources have seen decreases in emissions from 
1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?

        Use ggplot2 plotting system to make a plot to answer this question

4. Accross the United States, how have emissions from coal combustion-related sources
changed from 1999-2008?

5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California(fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

