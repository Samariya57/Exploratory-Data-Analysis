#Download data with the given link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "AirData.zip")
unzip("AirData.zip", exdir="AirData")
files <- list.files("AirData")
filename1 <- paste("./AirData/",files[1],sep="")
filename2 <- paste("./AirData/",files[2],sep="")
data1 <- readRDS(filename1)
data2 <- readRDS(filename2)

# Filter data for Baltimore and aggregate by year and type
baltData <- subset(data2, data2$fips == "24510")
third<-aggregate(baltData$Emissions, by=list(baltData$type,baltData$year), sum)

#Plotting
library(ggplot2)
ggplot(third, aes(factor(Group.2), fill=factor(Group.1), weight=x)) + 
  geom_bar(position="dodge") + 
  labs(x="Year", y="Emissions in tons", fill="Type", 
       title="Total emissions for Baltimore city by years and types")

# Save to png file

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()