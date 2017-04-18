# Download file and unzip

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data.zip")
unzip("data.zip", exdir="data")
files <- list.files("data")
x<-paste("./data_for_hw/",files[1],sep="")

# read file and header
my_data<-read.table(x, header=TRUE,skip=66636, nrow=2882, sep=";")
y<-read.table(x, nrow=1)
u<-as.character(y[,1])

u<- strsplit(u, split=";")
z<- matrix(u[[1]], nrow=1)
names(my_data)<-z

# transform Date and Time into one column

my_data$Date<-as.Date(strptime(my_data$Date, format="%d/%m/%Y", tz=""))
my_data<-transform(my_data, DateTime=as.POSIXct(strptime(
  paste(Date, Time),format="%Y-%m-%d %H:%M:%S", tz="")))

# plotting

par(mfrow=c(2,2))

##PLOT 1
with(my_data, plot(DateTime,Global_active_power, type="l", 
                   xlab="", ylab="Global Active Power"))
##PLOT 2
with(my_data,plot(DateTime,Voltage, type="l", xlab="datetime", ylab="Voltage"))

##PLOT 3
plot (my_data$DateTime, my_data$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
lines(my_data$DateTime, my_data$Sub_metering_2, col="red")
lines(my_data$DateTime, my_data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1))
#PLOT 4
with(my_data,plot(DateTime,Global_reactive_power, type="l", xlab="datetime", 
                  ylab="Global_reactive_power"))

#send to file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
