library(data.table)

# loading data
DT <- fread("./data/household_power_consumption.txt",na.strings = c("?",""),colClasses = rep("character",9))

# subsetting
DTS <- DT[DT$Date %in% c("1/2/2007","2/2/2007"),]

# transform data and time to Date/Time classes and insert a new column datetime in the DT
DTS <- DTS[, Date:=as.Date(Date , "%d/%m/%Y")]
DTS <- DTS[, datetime := as.POSIXct(strptime(paste(as.character(DTS$Date),DTS$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S"))]

DTS <- DTS[, Global_active_power:=as.numeric(Global_active_power)]

# plot 3
png(file="plot3.png", width = 480, height = 480, units = "px", bg = "white")
plot(DTS$datetime,DTS$Sub_metering_1,xlab = "", ylab="Energy sub metering",type="n")
lines(DTS$datetime,DTS$Sub_metering_1,type="l",col="black")
lines(DTS$datetime,DTS$Sub_metering_2,type="l",col="red")
lines(DTS$datetime,DTS$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()