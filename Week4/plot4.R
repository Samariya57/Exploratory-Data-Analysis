#Download data with the given link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "AirData.zip")
unzip("AirData.zip", exdir="AirData")
files <- list.files("AirData")
filename1 <- paste("./AirData/",files[1],sep="")
filename2 <- paste("./AirData/",files[2],sep="")
data1 <- readRDS(filename1)
data2 <- readRDS(filename2)

# Filter SCC codes for coal combustion-related emissions
library(dplyr)
forth_CSS <- data1[grepl( "comb", data1$SCC.Level.One, ignore.case = TRUE)& 
                     grepl("Coal", data1$SCC.Level.Four, ignore.case = TRUE), ]
forth_CSS <- forth_CSS$SCC
# Filter data with codes obtained on the previous step
forthData <- data2[data2$SCC %in% forth_CSS,]
# Aggregate info by year
forth<-aggregate(forthData$Emissions, by=list(forthData$year), sum)

#Plotting
barplot(forth$x, names.arg = forth$Group.1, horiz = TRUE, col = forth$Group.1, 
        xlab="Emissions given in tons", 
        main="Emissions from coal combustion-related (1999–2008)")
# Save to png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()