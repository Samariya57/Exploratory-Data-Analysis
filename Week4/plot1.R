#Download data with the given link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "AirData.zip")
unzip("AirData.zip", exdir="AirData")
files <- list.files("AirData")
filename1 <- paste("./AirData/",files[1],sep="")
filename2 <- paste("./AirData/",files[2],sep="")
data1 <- readRDS(filename1)
data2 <- readRDS(filename2)

# Aggregate emissions by years 
totalEm <- tapply(data2$Emissions, data2$year, sum)

#Plotting
barplot(names.arg=names(totalEm),totalEm, xlab="Year", 
        ylab="Emissions given in tons", col="lightblue", 
        main="Total emissions across the US (1999-2008)" )

# Save to png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()