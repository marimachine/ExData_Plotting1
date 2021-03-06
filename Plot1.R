# Plot 1
dat <- read.table("household_power_consumption.txt",header =TRUE, sep =";")

library(lubridate)
library(dplyr)
#dat$Time<-hms(dat$Time)

dat$datetime <- paste(dat$Date,dat$Time)
dat$Date<-dmy(dat$Date)
class(dat$datetime)
dat$datetime<- dmy_hms(dat$datetime)

dats<- subset(dat, Date>= "2007-02-01" & Date <= "2007-02-02")

label <- tolower(names(dats))
label <- gsub("_","",label)
colnames(dats) <-  label
names(dats)

# create datetime from date and time variables
dats$datetime <- paste(dats$date, dats$time)
strptime(dats, "%d/%m/%Y %H:%M:%S")

#convert remaining factors to numeric
indx <- sapply(dats, is.factor)
dats[indx] <- lapply(dats[indx], function(x) as.numeric(as.character(x)))


dev.cur() # opens connections to plotting system
hist(dats$globalactivepower, col="red", breacks = 12, ylab = "Frequency", xlab="Global Active Power (kilowatts)",main="Global Active Power") 
dev.copy(png, file ="Plot1.png", width=480, height=480) #This will | copy your screen plot to a png file in your working directory which you can view AFTER you close the device.
dev.off()
