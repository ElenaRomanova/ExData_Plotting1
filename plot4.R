library(sqldf)

#loading from file only rows with date 01/02/2007 or 02/02/2007
file <- 'household_power_consumption.txt'
df <- read.csv.sql(file, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'", header = TRUE, sep = ";")
date <- paste(df[,1], df[,2])
DateTime <- strptime(date, format = '%d/%m/%Y %H:%M:%S')
new_set <- cbind(DateTime, df[3:9])

#creating plot with name for y axis and 3 graphics for sub_metering
par(mfrow=c(2, 2))

#adding first plot of global active power
plot(new_set$DateTime, new_set$Global_active_power, type='n', ylab='Global Active Power (kilowatts)', xlab='')
for (i in 1:length(new_set$Global_active_power)) { 
    lines(new_set$DateTime, new_set$Global_active_power, pch='.') 
} 

#adding second plot of voltage
plot(new_set$DateTime, new_set$Voltage, type='n', ylab='Voltage', xlab='datetime', ylim=c(234, 246))
for (i in 1:length(new_set$Voltage)) { 
    lines(new_set$DateTime, new_set$Voltage, pch='.') 
} 

#adding third plot of sub meterings
plot(new_set$DateTime, new_set$Global_active_power, type='n', ylab='Energy sub metering', xlab='', ylim=c(0,38))
for (i in 1:length(new_set$DateTime)) {
    lines(new_set$DateTime, new_set$Sub_metering_1, pch='.', col='black') 
    lines(new_set$DateTime, new_set$Sub_metering_2, pch='.', col='red')
    lines(new_set$DateTime, new_set$Sub_metering_3, pch='.', col='blue')     
} 
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

#adding forth plot of global reactive power
plot(new_set$DateTime, new_set$Global_reactive_power, type='n', ylab='Global_reactive_power', xlab='datetime')
for (i in 1:length(new_set$Global_reactive_power)) { 
    lines(new_set$DateTime, new_set$Global_reactive_power, pch='.') 
} 

#save plot to png file
dev.copy(png, "plot4.png")
dev.off()
