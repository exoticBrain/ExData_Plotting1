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

# Generate the first plot
plot1 <- plot(datetime_form, as.numeric(filtered_data$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Generate the second plot plus adding features to it, such as legend and colors ...
plot2 <- plot(datetime_form, filtered_data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(datetime_form, filtered_data$Sub_metering_2, col = "red")
lines(datetime_form, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Generate the third plot
plot3 <- plot(datetime_form, filtered_data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# Generate the forth plot
plot4 <- plot(datetime_form, filtered_data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

# Set up the layout
par(mfcol = c(2, 2))

# Generate all the plots 
plot1
plot2
plot3
plot4

# Create the png file
dev.copy(png, "plot4.png")
dev.off()

