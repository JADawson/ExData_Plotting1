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

##plot 1
png("./plot1.png",unit="px", width=480, height=480, type="windows")
hist(hdata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()