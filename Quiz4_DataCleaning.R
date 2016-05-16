### Week 4 Quiz

## Question 1

# Download the 2006 microdata survey about housing for the state of Idaho using 
# download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

getwd()
Idaho_file <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(Idaho_file, "/Users/andreia/DataCleaning/hid.csv", 
              method = "curl")

#Reading the data
Idat <- read.csv("hid.csv", header = TRUE, sep = ",")

library(dplyr)
tbl_df(Idat)

# Apply strsplit() to split the names of the data frame on the characters "wgtp"
# What is the value of the 123 element of the resulting list?

splitNames <- strsplit(names(Idat), "wgtp")
splitNames[[123]]

#or
splitNames <- strsplit(Idat, " ")
splitNames[[123]]


#############

wgtplist <- select(Idat, wgtp1:wgtp80)
head(wgtplist)
names1 <- names(wgtplist)

Idat2 <- gsub(("[[:alpha:]]"), names1, ",", "\\1_")
strsplit(Idat2, ",")
head(Idat2)

g1 <- gsub("([[:alpha:]]+)", ",", names1)
head(g1)
strsplit(g1, ",") [123] 

##################

l## Question 2

# Load the Gross Domestic Product data for the 190 ranked countries in this 
# data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

getwd()
GDPfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(GDPfile, "/Users/andreia/DataCleaning/GDP.csv", method = "curl")

# Read the data 
GDPdat <- read.csv("GDP.csv", skip = 5, nrows = 190, stringsAsFactors = F, 
                   header = F)
tbl_df(GDPdat)

# Remove the commas from the GDP numbers in millions of dollars and average 
# them. What is the average?
GDPdat$V5 <- gsub(",", "", GDPdat$V5)
GDPdat$V5 <- as.numeric(GDPdat$V5)
class(GDPdat$V5)
mean(GDPdat$V5)

# In the data set from Question 2 what is a regular expression that would allow
# to count the number of countries whose name begins with "United"?
# Assume that the variable with the country names in it is named countryNames.
# How many countries begin with United?

# Creating variable countryNames

GDPdat1 <- select(GDPdat, V1, V2, V4, V5)
colnames(GDPdat1) <- c("Id", "Ranking", "countryNames", "GDP dollars")
tbl_df(GDPdat1) 

library(dplyr)

length(grep("^United", GDPdat1$countryNames))

# Load the Gross Domestic Product data for the 190 ranked countries in this 
# data set:  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Read GDP data 
GDPfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(GDPfile, "/Users/andreia/DataCleaning/GDP.csv", method = "curl")
GDPdat <- read.csv("GDP.csv", skip = 5, nrows = 190, stringsAsFactors = F, 
                   header = F)
tbl_df(GDPdat)

# Read in FEDSTATS data

FEDSTATS <- read.csv("FEDSTATS.csv", stringsAsFactors = F)

head(FEDSTATS)

# Match the data based on the country shortcode. How many of the IDs match

#Renaming FGDP data
GDPdat <- select(GDPdat, V1, V2, V4, V5)
head(GDPdat)
colnames(GDPdat) <- c("CountryCode", "Ranking", "CountryName", "Value") 
head(GDPdat)

#Matching the 2 datasets by ID (CountryCode) just with variables from the 
# 1st dataset
mdat <- GDPdat[(GDPdat$CountryCode %in% FEDSTATS$CountryCode), ]
dim(mdat)
tbl_df(mdat)
# or Merging the 2 datasets with all the variables
mdat2 <- merge(GDPdat, FEDSTATS, by.x = "CountryCode", by.y = "CountryCode")
dim(mdat2)
tbl_df(mdat2)

# Of the countries for which the end of the fiscal year is available, 
# how many end in June?
length(tolower(grep("Fiscal year end: June", mdat2$Special.Notes)))

### Question 5
# use the quantmod package to get historical stock prices for publicly traded 
# companies on the NASDAQ and NYSE. Use the following code to download data on
# Amazon's stock price and get the times the data was sampled.

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN", auto.assign = FALSE)
sampleTimes = index(amzn)

#Check out the data structure and class
str(sampleTimes)
class(sampleTimes)

# How many values were collected in 2012? 
length(grep("2012", sampleTimes))

library(lubridate)

# How many valus were collected on Mondays in 2012?

# Matching years 2012
yearValues <- grep("2012", sampleTimes)
# Creating a vector to applying function wday to the data set
wdays <- sapply(sampleTimes, wday, label = TRUE)

# Applying the wdays function to the data set and calculating the number of 
# "Mondays" for the year 2012
length(which(wdays[yearValues] == "Mon"))

