## Install and load necessary packages
if(!("dplyr" %in% row.names(installed.packages())))
        install.packages("dplyr")

library(dplyr)

## Downloading data
if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "house.zip")
        unzip("house.zip")
}

## Loading data into R
house <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows = 2880)
names(house) <- c( "Date", "Time", "Global_active_power", "Global_reactive_power",
                   "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Converting Date and Time columns
house <- mutate(house, Date.Time=as.POSIXct(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S")))

## Plot 2 in png device
png("plot2.png")
with(house, plot(Date.Time, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n"))
with(house, lines(Date.Time, Global_active_power))
dev.off()