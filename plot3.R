## Download the file if it dowsn't already exist

destfile="household_power_consumption.txt" 
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(destfile)) {
      download.file(URL, "dataset.zip")
      unzip("dataset.zip")}

## Read the data only for the specific dates and assining column names and classes
Hdata <- read.table(destfile,header = FALSE,sep = ";", na.strings = c("?"),skip = 66637, nrows = 2880,
                    col.names = c("Date","Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                    colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

##converge the date and the time to one column in a Date class
Hdata$DateTime <- paste(Hdata$Date,Hdata$Time)
Hdata$DateTime <- strptime(Hdata$DateTime, "%d/%m/%Y %H:%M:%S")
Hdata <- cbind("datetime"= Hdata$DateTime,Hdata[,3:9])



## Create the histogram graph on the png device
png(filename = "plot3.png", width = 480, height = 480)

par(mfrow = c(1,1))
plot(Hdata$datetime,Hdata$Sub_metering_1, type = "l",main = "",ylab = "Energy sub metering",xlab = "")
lines(Hdata$datetime,Hdata$Sub_metering_2, col = "red" , type = "l")
lines(Hdata$datetime,Hdata$Sub_metering_3, col = "blue" , type = "l")
legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
        col=c("black","red","blue"), lwd=1, lty= 1, merge=FALSE )

dev.off()
