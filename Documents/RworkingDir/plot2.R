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
        png(file="plot2.png")
## make line plot plot2
        with(datau, plot(pa, Global_active_power, type = "l", 
                         xlab = "", ylab = "Global Active Power (kilowatts)"))
## close png device
        dev.off()