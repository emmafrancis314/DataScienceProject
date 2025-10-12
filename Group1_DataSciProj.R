setwd('/Users/mattamor/Library/CloudStorage/OneDrive-Personal/School/ECON 6374 - ProbStat/DataSciProj')
install.packages("data.table")
library(data.table)
install.packages("dplyr")
library(dplyr)

#####
#1 
#####
## downloaded data into wd from https://ffiec.cfpb.gov/data-publication/snapshot-national-loan-level-dataset/2020https://ffiec.cfpb.gov/data-publication/snapshot-national-loan-level-dataset/2020

#######
#2 
#######
## assigning colnames is moot. The dataset includes them as-is

########
#3
########
#Loading in the LAR from 2021 and 2023 using data.table::fread
## only importing the dataset with the columns of interest for question 3
LAR_21 <- fread('2021_public_lar.csv', select = c("activity_year","state_code","loan_amount","interest_rate"))
LAR_23 <- fread('2023_public_lar_csv.csv', select = c("activity_year","state_code","loan_amount","interest_rate"))
# Separating the data into AL+FL and the rest of the US
USLAR21 <- LAR_21[!state_code %in% c("AL","FL")]
ALFL21 <- LAR_21[state_code %in% c("AL","FL")]
USLAR23 <- LAR_23[!state_code %in% c("AL","FL")]
ALFL23 <- LAR_23[state_code %in% c("AL","FL")]
# Binding the data for both years
USLAR <- rbind(USLAR21,USLAR23)
ALFL <- rbind(ALFL21,ALFL23)
# Getting rid of datasets we don't need for the rest of Question 3
rm(LAR_21,LAR_23,USLAR21,USLAR23,ALFL21,ALFL23)
# Freeing unused memory
gc()

#3a
# Calculating the medians
median(USLAR$loan_amount, na.rm = TRUE) 
# Median loan amount for US excluding Alabama and Florida in 2021 and 2023: 
## $225,000
median(ALFL$loan_amount, na.rm = TRUE)  
# Median loan amount for Alabama and Florida in 2021 and 2023: 
## $225,000
## These are the same!
## The loan amounts are given in $10,000 intervals so
## it isn't surprising that the medians for FL and AL would be
## close to the median for the rest of the nation.

#3b
# Converting interest rate columns into numeric vectors,
## which "coerces" "Exempt" values into NAs, 
## which are removed by the mean formula.
USLARm <- as.numeric(USLAR$interest_rate) 
ALFLm <- as.numeric(ALFL$interest_rate) 
# Calculating the means
mean(USLARm,na.rm = TRUE) 
# Mean interest rate for US excluding Alabama and Florida in 2021 and 2023: 
## 4.144381%
mean(ALFLm,na.rm = TRUE)  
# Mean interest rate for Alabama and Florida in 2021 and 2023: 
## 4.392184%

# Clearing the memory to start the rest of the project
rm(list = ls())
gc()

#########
#4
#########
## While loading in these massive datasets,
## please run each line one at a time, 
## and wait for the process to complete.
## The code is attempting to minimize the memory load as it goes.

#4a
# Loading the full 2021 dataset
LAR_21 <- fread('2021_public_lar.csv')
# Overwriting the full 2021 csv with a filtered dataset,
## including only observations from Alabama and Florida.
LAR_21 <- LAR_21[state_code %in% c("AL","FL")]
gc()
# Loading and overwriting 2023 data with AL+FL dataset
LAR_23 <- fread('2023_public_lar_csv.csv')
LAR_23 <- LAR_23[state_code %in% c("AL","FL")]
gc()

#4b
# Binding 2021 and 2023
ALFL_LAR <- rbind(LAR_21,LAR_23)
# Removing redundant data
rm(LAR_21,LAR_23)
gc()
