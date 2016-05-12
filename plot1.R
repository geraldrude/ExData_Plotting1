
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

png('plot1.png', width=480, height=480)
hist(two_days$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="Red")
dev.off()

