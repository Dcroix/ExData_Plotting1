library(data.table)
a <- fread("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
## Name the columns properly.
colnames(a) <- c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage", "Global Intensity", "Sub metering 1", "Sub metering 2", "Sub metering 3")
##Convert a$Date character into "Date" using as.Date with proper format
a$Date <- as.Date(a$Date, format = "%d/%m/%Y")
##Convert dates and times and paste them together
DateTime <- strptime(paste(a$Date, a$Time), "%Y-%m-%d %H:%M:%S")
DateTime <- as.POSIXct(DateTime)
##Add new column DateTime to Data Frame "a"
library(dplyr)
a <- mutate(a, DateTime)
##Replace the old columns Date and Time with the new column DateTime
a <- select(a, 3,4,5,6,7,8,9,10)
##Arrange in a way that DateTime is the first column
a <- a[c(8,1,2,3,4,5,6,7)]
##Set the parameters for plotting
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
##Create the specified plots
##Upper Left Plot
plot(a$DateTime, a$`Global Active Power`, col = "black", type = "l", xlab ="", ylab = "Global Active Power")
##Upper Right Plot
plot(a$DateTime, a$Voltage, col = "black", type = "l", xlab = "datetime", ylab ="Voltage")
##Lower Left Plot
plot(a$DateTime, a$`Sub metering 1`, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
lines(a$DateTime, a$`Sub metering 2`, col = "red")
lines(a$DateTime, a$`Sub metering 3`, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##Lower Right Plot
plot(a$DateTime, a$`Global Reactive Power`, col = "black", type = "l", xlab ="datetime", ylab = "Global_reactive_power")
##Produce the png file with the specified name
dev.copy(png, file = "plot4.png", height = 480, width = 480)
##close
dev.off()