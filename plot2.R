library(dplyr)
library(lubridate)

# Read the data as a table while skipping header row and replacing the NAs with the correct value
dt <- read.table('household_power_consumption.txt', sep = ';', skip = 1, na.strings = "?")

# Append the right header names
names(dt) <- c("Date","Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


# Subste the data in the given range
filtered_data <- subset(dt, dt$Date=="1/2/2007" | dt$Date =="2/2/2007")

# Change the date and time format
date_form <- as.Date(filtered_data$Date, format = "%d/%m/%Y")
time_form <- strptime(filtered_data$Time, format = "%H:%M:%S")
datetime_form <- as.POSIXct(paste(date_form, filtered_data$Time))

# Generate the plot
plot(datetime_form, as.numeric(as.character(filtered_data$Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, "plot2.png")

dev.off()
rm('dt', 'filtered_data', 'date_form', 'time_form', 'datetime_form')