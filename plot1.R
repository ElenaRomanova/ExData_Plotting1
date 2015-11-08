library(sqldf)

#loading from file only rows with date 01/02/2007 or 02/02/2007
file <- 'household_power_consumption.txt'
df <- read.csv.sql(file, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'", header = TRUE, sep = ";")

#creating histogram with title, name for x axis and red bars
hist(df$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = "Global Active Power", col=c('red'))

#save plot to png file
dev.copy(png, "plot1.png")
dev.off()
