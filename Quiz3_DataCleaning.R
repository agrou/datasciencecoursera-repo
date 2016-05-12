
# Quiz 3 - Data Cleaning - Coursera

#### Question 1

# Getting the data
getwd()
USAlink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
USAdown <- download.file(USAlink, 
                         destfile = "/Users/andreia/DataCleaning/usa.csv",
                         method = "curl")
# Reading the data
USAdata <- read.csv("/Users/andreia/DataCleaning/usa.csv")
head(USAdata)

# Create a logical vector that identifies the households greater than 10 acres
# who sold more than $10,000 worth of agriculture products. Assign that logical
# vector to the variable agricultureLogical 

# subsetting using logical statements and
# Apply the which() function to identify the rows of the data frame of the 
# data frame where the logical vector is true

agricultureLogical <- USAdata[which(USAdata$ACR == 3 & USAdata$AGS == 6),]
head(agricultureLogical)

#### Question 2 

# Load the packages
library(jpeg)

# Getting the data

filejpeg <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(filejpg, 
              destfile = "/Users/andreia/DataCleaning/getdata%2Fjeff.jpg",
              method = "curl")

# Use the parameter native = TRUE

data1 <- readJPEG("/Users/andreia/DataCleaning/getdata%2Fjeff.jpg", 
                  native = TRUE)

# What are the 30th and 80th quantiles of the 
# resulting data? 

quantile(data1, probs = c(0.3, 0.8))

#### Question 3 

# Load the Gross Domestic Product data for the 190 ranked countries
# in this data set: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

fileFGDP <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileFGDP, destfile = "/Users/andreia/DataCleaning/FGDP.csv",
              method = "curl")

fileFEDSTATS <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileFEDSTATS, destfile = "/Users/andreia/DataCleaning/FEDSTATS.csv",
              method = "curl")

# Read in the data

FGDP <- read.csv("FGDP.csv", skip = 5, nrows = 190, stringsAsFactors = F, 
                 header = F)
FEDSTATS <- read.csv("FEDSTATS.csv", stringsAsFactors = F)

head(FGDP)
head(FEDSTATS)

# Match the data based on the country shortcode. How many of the IDs match

#Renaming FGDP data
FGDPdat <- select(FGDP, V1, V2, V4, V5)
head(FGDPdat)
colnames(FGDPdat) <- c("CountryCode", "Ranking", "CountryName", "Value") 
head(FGDPdat)

#Matching the 2 datasets by ID (CountryCode) just with variables from the 1st dataset
mdat <- FGDPdat[(FGDPdat$CountryCode %in% FEDSTATS$CountryCode), ]
dim(mdat)
# or Merging the 2 datasets with all the variables
mdat2 <- merge(FGDPdat, FEDSTATS, by.x = "CountryCode", by.y = "CountryCode")
dim(mdat2)

#Sort the dataframe in descending order by GDP rank (so United States is last)
#What is the 13th country in the resulting data frame

library(dplyr)
msort <- arrange(mdat2, desc(Ranking))
head(msort, 13)

#### Question 4

#Loading required packages
library(reshape2)
library(plyr)
library(tidyr)

# What is the average GDP ranking for the "High income: OECD" and "High income: 
# non OECD group

sepData <- select(mdat2, CountryCode, Ranking, Value, Income.Group) %>%
                separate(Income.Group, c("Income", "Group"), sep = ":")

ddply(sepData, ~Group, summarise, mean = mean(Ranking))

#### Question 5

# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations 
#with highest GDP

Quantiles = cut(sepData$Ranking, 5)
Quantiles

GDPtbl <- table(sepData$Income, Quantiles)
GDPtbl

