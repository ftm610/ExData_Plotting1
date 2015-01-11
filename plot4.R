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
# PLOT 4
# Multiple Plots

# 4 figures arranged in 2 rows and 2 columns
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

# Plot 4-1 (Top Left) = Plot 2
# Line: X = Day of Week, Y = Global Active Power
# png(filename = "plot4-1.png", width = 480, height = 480)
plot(data_filter$Time, data_filter$Global_active_power, type = "l", xlab = "",  ylab = "Global Active Power")

# Plot 4-2 (Top Right)
# Line: X = Day of Week, Y = Voltage
plot(data_filter$Time, data_filter$Voltage, type = "l", xlab = "datetime",  ylab = "Voltage")

# PLOT 4-3 (Bottom Left) = Plot 3
# Multiple Lines: X = Day of Week, Y = Energy Sub Metering

plot(data_filter$Time, data_filter$Sub_metering_1, type = "l", xlab = "",  ylab = "Energy sub metering")
lines(data_filter$Time, data_filter$Sub_metering_2, type = "l", col = "red")
lines(data_filter$Time, data_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")

# PLOT 4-4 (Bottom Right)
# Line: X = Day of Week, Y = Global Reactive Power
plot(data_filter$Time, data_filter$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off() 