url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("epc.zip")) {
    download.file(url, destfile="epc.zip", method="curl")
    unzip("epc.zip")
}

#read the data in epc_data
epc_data <- read.table("household_power_consumption.txt", header=TRUE, sep =";", na.string="?")

#Save the data of interest to part_epc_data
part_epc_data <- epc_data[(epc_data$Date=="1/2/2007" | epc_data$Date=="2/2/2007" ), ]
#Format and create a new column called DateTime
part_epc_data$Date <- as.Date(part_epc_data$Date, format="%d/%m/%Y")
dateTime <- paste(part_epc_data$Date, part_epc_data$Time)
part_epc_data$DateTime <- as.POSIXct(dateTime)

# Plot the graph
plot(part_epc_data$Sub_metering_1~part_epc_data$DateTime, ylab="Energy sub meeting", xlab="", type="l")
lines(part_epc_data$Sub_metering_2~part_epc_data$DateTime, col="red")
lines(part_epc_data$Sub_metering_3~part_epc_data$DateTime, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# copy in plot1.png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
