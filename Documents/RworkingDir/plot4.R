## read data from txt file
        data <- read.table("household_power_consumption.txt", 
                           header = TRUE, sep = ";", na.string = "?")

## convert Date
        data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

## select data from dates 2007-02-01 and 2007-02-02
        datau <- data[(data[,1] < "2007-02-03" & data[,1] > "2007-01-31"),]

## combind date and time together 
        pasd <- paste(datau$Date, as.character(datau$Time))
        pa <- strptime(pasd, format = "%Y-%m-%d %H:%M:%S")
        datau <- cbind(pa, datau)

## open png device
        png(file = "plo4.png")
## make multiple plot graph plot4
        par(mfrow = c(2,2))
        with(datau, plot(pa, Global_active_power, type = "l", 
                         xlab = "", ylab = "Global Active Power (kilowatts)"))
        with(datau, plot(pa, Voltage, xlab = "datetime", type = "l"))
        with(datau, plot(pa, Sub_metering_1, type = "l", 
                         xlab = "", ylab="Energy sub metering"))
        lines(datau$pa, datau$Sub_metering_3, type = "l", col = "blue")
        lines(datau$pa, datau$Sub_metering_2, type = "l", col = "red")
        ## add legends
        legend("topright", bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), lty = c(1,1,1), lwd=c(1, 2, 2))
        with(datau, plot(pa, Global_reactive_power, type = "l", 
                         xlab = "datetime"))

## close png device
dev.off()