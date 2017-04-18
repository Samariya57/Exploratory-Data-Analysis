#Download data with the given link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "AirData.zip")
unzip("AirData.zip", exdir="AirData")
files <- list.files("AirData")
filename1 <- paste("./AirData/",files[1],sep="")
filename2 <- paste("./AirData/",files[2],sep="")
data1 <- readRDS(filename1)
data2 <- readRDS(filename2)


# Filter data for Baltimore city
baltData <- subset(data2, data2$fips == "24510")
# Filter data for codes for motor vehicle emissions
fifth_CSS <- data1[grepl( "vehicle", data1$EI.Sector, ignore.case = TRUE), ]
fifth_CSS <- fifth_CSS$SCC
# Filter data for Baltimore with codes for motor vehicle emissions
fifthData <- baltData[baltData$SCC %in% fifth_CSS,]
# Aggregate info by year
fifth<-aggregate(fifthData$Emissions, by=list(fifthData$year), sum)

# Plotting
barplot(fifth$x, names.arg = fifth$Group.1, horiz = TRUE, col = fifth$Group.1, 
        xlab="Emissions given in tons", 
        main="Emissions from motor vehicle sources in Baltimore city")
# Save to png file
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()