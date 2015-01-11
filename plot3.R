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
# PLOT 3
# Multiple Lines: X = Day of Week, Y = Energy Sub Metering

png(filename = "plot3.png", width = 480, height = 480)
plot(data_filter$Time, data_filter$Sub_metering_1, type = "l", xlab = "",  ylab = "Energy sub metering")
lines(data_filter$Time, data_filter$Sub_metering_2, type = "l", col = "red")
lines(data_filter$Time, data_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1))
dev.off() 