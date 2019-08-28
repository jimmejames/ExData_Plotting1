##reading date correctly sourced post on stackoverflow
##https://stackoverflow.com/questions/13022299/specify-custom-date-format-for-colclasses-argument-in-read-table-read-csv

library(lubridate)
##download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","hpc.zip")
##unzip("hpc.zip")

##Prepare to read date in correct format
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
setClass("myDate")

##read semi-colon separated file with nearly correct formats 
hpc <- read.csv("household_power_consumption.txt", sep=";", na.strings = c("","?","NA"), colClasses = c("myDate", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

##subset based on date
startDate <- as.Date("01/02/2007", "%d/%m/%Y")
endDate <- as.Date("02/02/2007", "%d/%m/%Y")
hpc_subset <- subset(hpc,hpc$Date >= startDate & hpc$Date <= endDate)

##combine date & time into one column
hpc_subset$DateTime <-ymd_hms(paste(hpc_subset$Date,hpc_subset$Time))

##export plot
png("plot1.png", height = 480, width = 480)
hist(hpc_subset$Global_active_power,col="red", xlab ="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()