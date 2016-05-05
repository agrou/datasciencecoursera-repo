#####################################################################

# Question 1

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "4561a210d1a458ad66a6",
                   secret = "d8bb0fe0e86c64bc611eef892849742f7553dc89")

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
str(req)
library(jsonlite)

names(req)

# 5 Convert the data from json into a data frame format
dat1 <- fromJSON("https://api.github.com/users/jtleek/repos")
names(dat1)
str(dat1)
str(dat1$created_at)
dat2 <- dat1[8,]
View(dat2)

############################################################################

# Question 2

# Install SQL package
install.packages("sqldf")
library(sqldf)

# Download the data from the link 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
getwd()
file1 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
                       destfile = "/Users/andreia/DataCleaning/acs.csv", method = "curl")
acs <- read.csv("/Users/andreia/DataCleaning/acs.csv")

# Testing the commands 
test4 <- sqldf("select pwgtp1 from acs where AGEP < 50")
head(test4)

test3 <- sqldf("select * from acs where AGEP < 50")
head(test3)

test2 <- sqldf("select pwgtp1 from acs")
head(test2)

test1 <- sqldf("select * from acs")
head(test1)

################################################################# 

# Question 3

# The equivalent function to unique(acs$AGEP)

test0 <- unique(acs$AGEP)
head(test0)
testC <- sqldf("select distinct AGEP from acs")
head(testC)
testA <- sqldf("select AGEP where unique from acs")
testB <- sqldf("select unique * from acs")
testD <- sqldf("select distinct pqgtp1 from acs")

#################################################################
# Question 4

# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from 
# this page: http://biostat.jhsph.edu/~jleek/contact.html

# Open the connection
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
# read the lines
htmlCode = readLines(con)
htmlCode
# determine the number of characters for line 10
nchar(htmlCode[[10]])
# determine the number of characters for all the requested lines
nchar(htmlCode[c(10, 20, 30, 100)])
# Check if elements are non-empty strings
nzchar(htmlCode[c(10, 20, 30, 100)])
close(con)

##################################################################

# Question 5

# Read this data set 
# (https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for) 
# into R and report the sum of the numbers in the fourth of 
# the nine columns 

library(readr)

fix1 <- read.fwf(
        file = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", 
        skip = 4, 
        widths = c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4))

sum(fix1$V4)

