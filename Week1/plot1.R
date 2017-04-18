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

# plotting

hist(my_data$Global_active_power, col="red", main="Global active power", 
     xlab="Globall active power (kilowatts)")

#send to file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()