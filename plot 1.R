##I have opened the file first using the Large Text File Viewer to See which rows I need to 
##retrieve as a subset since I have been trying to open the file as it is but it is too big for me to
##do so. From there I knew that I need to skip 66,637 lines and only work on 2,880 rows which
##covers the data from Feb 1, 2007 to Feb 2, 2007 per given instructions.
library(data.table)
a <- fread("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
##After checking the characteristics of the variables with str() and checking how it
##looks like with head(), I decided to name the columns properly.
colnames(a) <- c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage", "Global Intensity", "Sub metering 1", "Sub metering 2", "Sub metering 3")
##Create the Specified Histogram
hist(a$'Global Active Power', col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
##Produce the png file with the specified name
dev.copy(png,file = "plot1.png", height = 480, width = 480)
##close
dev.off()