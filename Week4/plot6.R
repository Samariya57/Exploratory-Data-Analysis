#Download data with the given link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "AirData.zip")
unzip("AirData.zip", exdir="AirData")
files <- list.files("AirData")
filename1 <- paste("./AirData/",files[1],sep="")
filename2 <- paste("./AirData/",files[2],sep="")
data1 <- readRDS(filename1)
data2 <- readRDS(filename2)

# Function for converting codes into city names
renames <- function(x) {
  if (x =="24510") {
    return ("Baltimore city")
  } else{
    return("Los Angelos")
  }
}
# Filter info for Baltimore and Loa Angelos
baltLosData <- subset(data2, data2$fips == "24510" |data2$fips == "06037")
# Filter codes for emissions from motor vehicle sources
six_CSS <- data1[grepl( "vehicle", data1$EI.Sector, ignore.case = TRUE), ]
six_CSS <- six_CSS$SCC
# Filter data for two cities with codes
sixData <- baltLosData[baltData$SCC %in% six_CSS,]
# Convert city codes into names
sixData <- mutate(sixData, name=sapply(sixData$fips, renames))
# aggregate info by year and city name
sixth<-aggregate(sixData$Emissions, by=list(sixData$year,sixData$name), sum)

# Plotting
ggplot(sixth, aes(factor(Group.1), fill=factor(Group.2), weight=x)) + 
  geom_bar(position="dodge") + 
  labs(x="Year", y="Emissions in tons", fill="City",
       title = "Comparison between Baltimore and Los Angelos")

# Save to png file
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()