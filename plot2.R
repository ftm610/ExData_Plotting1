#############################################################################################
# set working directory
path_wd = "C:\\Users\\Frank\\Documents\\Coursera\\Exploratory_Data_Analysis\\Projects\\Project1"
setwd(path_wd)

# load required packages
library(dplyr)
library(lubridate)

#############################################################################################
# download and extract datasets

# unzip downloaded data
unzip("exdata_data_household_power_consumption.zip")

# set paths to unzipped raw data
file = paste(path_wd,"\\household_power_consumption.txt", sep = "")

#############################################################################################
# read in and filter dataset

data <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
data <- tbl_df(data)

# convert date to R date format
data$Time <- dmy_hms(paste(data$Date, data$Time))
data$Date <- dmy(data$Date)

# filter data for dates 2007-02-01 and 2007-02-02
data_filter <- filter(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

#############################################################################################
# PLOT 2
# Line: X = Day of Week, Y = Global Active Power (kilowatts)

png(filename = "plot2.png", width = 480, height = 480)
plot(data_filter$Time, data_filter$Global_active_power, type = "l", xlab = "",  ylab = "Global Active Power (kilowatts)")
dev.off() 