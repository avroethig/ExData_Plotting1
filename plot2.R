library(data.table)

# loading data
DT <- fread("./data/household_power_consumption.txt",na.strings = c("?",""),colClasses = rep("character",9))

# subsetting
DTS <- DT[DT$Date %in% c("1/2/2007","2/2/2007"),]

# transform data and time to Date/Time classes and insert a new column datetime in the DT
DTS <- DTS[, Date:=as.Date(Date , "%d/%m/%Y")]
DTS <- DTS[, datetime := as.POSIXct(strptime(paste(as.character(DTS$Date),DTS$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S"))]

DTS <- DTS[, Global_active_power:=as.numeric(Global_active_power)]

# plot 2
png(file="plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(DTS$datetime,DTS$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="n")
lines(DTS$datetime,DTS$Global_active_power,type="l")
dev.off()