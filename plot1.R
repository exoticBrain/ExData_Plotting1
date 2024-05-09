library(dplyr)

df <- read.csv('dataset.csv', header = TRUE)

hist(df$Global_active_power, xlab = "Global_active_power (kilowats)", col = "red", main = "Global active power")

dev.copy(png, "plot1.png")
dev.off()