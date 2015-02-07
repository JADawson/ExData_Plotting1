library(dplyr)
library(lubridate)

## Course Project Week One
setwd("~/RWorking/ExpAn/Course Project One")

##set the filepath of the source data file
myfilepath <-"./household_power_consumption.txt"

hdata <- read.table(myfilepath,sep=";", header=TRUE,na.strings="?",
                    colClasses=c(rep("character",times=2), rep("numeric",times=7)))

##convert the character date and time to Date Time using lubridate
hdata <- mutate(hdata,DateTime=dmy_hms(paste(hdata$Date,hdata$Time)))

##convert the date to correct format
hdata$Date <- dmy(hdata$Date)

##filter for the 1st and 2nd of Feb 2007
hdata <- filter(hdata,Date=="2007-02-01"|Date=="2007-02-02")

png("./plot4.png",unit="px", width=480, height=480, type="windows")
par(mfrow=c(2,2))
    plot(hdata$DateTime,hdata$Global_active_power, type="l", xlim=range(hdata$DateTime), ylim=range(hdata$Global_active_power), xlab="", ylab="Global Active Power")
    plot(hdata$DateTime,hdata$Voltage, type="l", xlim=range(hdata$DateTime), ylim=range(hdata$Voltage), xlab="datetime", ylab="Voltage")
    plot(hdata$DateTime,hdata$Sub_metering_1, type="l", xlim=range(hdata$DateTime), ylim=range(hdata$Sub_metering_1), xlab="", ylab="Energy sub metering")
        lines(hdata$DateTime, hdata$Sub_metering_2, col="red")
        lines(hdata$DateTime, hdata$Sub_metering_3, col="blue")
        legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty="solid", col=c("black","red","blue"),cex=0.75, bty="n")
plot(hdata$DateTime,hdata$Global_reactive_power, type="l", xlim=range(hdata$DateTime), ylim=range(hdata$Global_reactive_power), xlab="datetime", ylab="Global_reactive_power")
dev.off()
