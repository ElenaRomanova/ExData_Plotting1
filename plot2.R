library(sqldf)

#loading from file only rows with date 01/02/2007 or 02/02/2007
file <- 'household_power_consumption.txt'
df <- read.csv.sql(file, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'", header = TRUE, sep = ";")
date <- paste(df[,1], df[,2])
DateTime <- strptime(date, format = '%d/%m/%Y %H:%M:%S')
new_set <- cbind(DateTime, df[3:9])

#creating plot with name for y axis and points connected with lines
plot(new_set$DateTime, new_set$Global_active_power, type='n', ylab='Global Active Power (kilowatts)', xlab='')
for (i in 1:length(new_set$Global_active_power)) { 
    lines(new_set$DateTime, new_set$Global_active_power, pch='.') 
} 

#save plot to png file
dev.copy(png, "plot2.png")
dev.off()
