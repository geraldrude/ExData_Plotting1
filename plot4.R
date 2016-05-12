library(gdata)

pwr_df = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE)

#Convert the collumns to numeric values
numeric_cols <- c(3,4,5,6,7,8,9)
pwr_df[,numeric_cols] <- apply(pwr_df[,numeric_cols], 2, function(x) as.numeric(as.character(x)))

#Add a timestamp collumn with the timestamp derived from Time/Date collumns
pwr_df <- within(pwr_df, { timestamp = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")})

#Subset the data into two days during February, 2007
two_days <- subset(pwr_df, timestamp > "2007-02-01") 
two_days <- subset(two_days, timestamp < "2007-02-03")



#Select Device
png("plot4.png", height=480, width=480)

#Make a multiplot
par(mfrow=c(2,2))

#Create Plot #1
with(two_days, plot(timestamp, Global_active_power, ylab='Global Active Power (kilowatts)', 
                    xlab='', pch='.', type='n'))
with(two_days, lines(timestamp, Global_active_power, ylab='Global Active Power (kilowatts)',
                     xlab='', pch='.'))
#Plot #2
with(two_days, plot(timestamp, Voltage, ylab="Voltage", xlab="datetime", type="n"))
with(two_days, lines(timestamp, Voltage))

#Plot #3
with(two_days, plot(timestamp, Sub_metering_1, ylab="Energy sub metering",xlab="", type="n"))
with(two_days, lines(timestamp, Sub_metering_1))
with(two_days, lines(timestamp, Sub_metering_2, col='red'))
with(two_days, lines(timestamp, Sub_metering_3, col='blue'))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), lwd=c(2,2,2), col=c("black",'red','blue'))

#Plot #4
with(two_days, plot(timestamp, Global_reactive_power, ylab="Global_reactive_power", 
                    xlab="datetime", type="n"))

with(two_days, lines(timestamp, Global_reactive_power, ylab="Global_reactive_power", 
                    xlab="datetime"))

dev.off()
