## read data with ";" as delimiter, "?" as unknown
## need to specify na.strings, otherwise the data columns are identified as factors
power<-read.csv("household_power_consumption.txt",sep=";",na.strings = "?")

## get subset for data on 2 days
## format of days in the raw data is Day/Month/Year
## 2007-02-01, 2007-02-02 --> 1/2/2007, 2/2/2007
power_2days<-subset(power,Date=="1/2/2007" | Date=="2/2/2007")

## change date and time
power_2days$Date<-as.Date(power_2days$Date,format="%d/%m/%Y")
power_2days$DateTime<-strptime(paste(power_2days$Date,power_2days$Time),format="%Y-%m-%d %H:%M:%S")

## make plot 1
hist(power_2days$Global_active_power,col="red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png,"plot1.png")
dev.off()

## make plot 2
with(power_2days,plot(DateTime,Global_active_power,type = "l",xlab = "",ylab="Global Active Power (kilowatts)"))
dev.copy(png,"plot2.png")
dev.off()

## make plot 3
with(power_2days,plot(DateTime,Sub_metering_1,type = "l",col="black",xlab = "",ylab="Energy sub metering"))
## add lines into the plot
lines(power_2days$DateTime,power_2days$Sub_metering_2,col="red")
lines(power_2days$DateTime,power_2days$Sub_metering_3,col="blue")
## add legend with names of columns
legend("topright",legend =names(power_2days[7:9]),text.col=c("black","red","blue"))
dev.copy(png,"plot3.png")
dev.off()

## make plot 4
## plot 2 by 2 fill the 1st column then 2nd column
par(mfcol=c(2,2))
with(power_2days,plot(DateTime,Global_active_power,type = "l",xlab = "",ylab="Global Active Power (kilowatts)"))
with(power_2days,plot(DateTime,Sub_metering_1,type = "l",col="black",xlab = "",ylab="Energy sub metering"))
lines(power_2days$DateTime,power_2days$Sub_metering_2,col="red")
lines(power_2days$DateTime,power_2days$Sub_metering_3,col="blue")
## remove the box for legend, and compact the space between legends
legend("topright",legend =names(power_2days[7:9]),text.col=c("black","red","blue"),bty = "n", y.intersep=0.5)
plot(power_2days$DateTime,power_2days$Voltage,xlab="datetime",ylab="Voltage",type="l")
plot(power_2days$DateTime,power_2days$Global_reactive_power,xlab="datetime",ylab="Global reactive power",type="l")
dev.copy(png,"plot4.png")
dev.off()
