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

## Plotting in png device
png("plot4.png")

par(mfcol=c(2,2))

## Plot 4_1
with(house, plot(Date.Time, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
with(house, lines(Date.Time, Global_active_power))

## Plot 4_2
with(house, plot(Date.Time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
with(house, lines(Date.Time, Sub_metering_1))
with(house, lines(Date.Time, Sub_metering_2, col="red"))
with(house, lines(Date.Time, Sub_metering_3, col="blue"))
with(house, legend( "topright", lty = 1, col=c("black", "red", "blue"), 
                    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))

## Plot 4_3
with(house, plot(Date.Time, Voltage, xlab="datetime", type="n"))
with(house, lines(Date.Time, Voltage))

## Plot 4_4
with(house, plot(Date.Time, Global_reactive_power, xlab="datetime", type="n"))
with(house, lines(Date.Time, Global_reactive_power))

dev.off()