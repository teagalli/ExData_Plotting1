# Get Data
# -----------------------------------------------------------------------------------------------------------------------------------
ProjectFolder <- "~/Course Project"
dir.create(ProjectFolder)
setwd(ProjectFolder)

ZipDataFolder <- paste0(getwd(), "/Data.zip")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, ZipDataFolder)
unzip(ZipDataFolder, list = FALSE, overwrite = TRUE, exdir = paste0(ProjectFolder))

DataFile <- paste0(ProjectFolder,"/household_power_consumption.txt")

DataColNames <- read.table(DataFile, nrow = 1, sep = ";")
PowerConsumptionDataSet <- read.table(DataFile, sep = ";", skip = (min(grep("1/2/2007", readLines(DataFile))) - 1), 
                                      nrow = (min(grep("3/2/2007", readLines(DataFile))) - min(grep("1/2/2007", readLines(DataFile)))))

colnames(PowerConsumptionDataSet) <- unlist(DataColNames[1,])
PowerConsumptionDataSet$Date <- as.Date(PowerConsumptionDataSet$Date, "%d/%m/%Y")
PowerConsumptionDataSet$DateTime <- paste(PowerConsumptionDataSet$Date, PowerConsumptionDataSet$Time)
PowerConsumptionDataSet$DateTime <- strptime(PowerConsumptionDataSet$DateTime, "%Y-%m-%d %H:%M:%S")
# -----------------------------------------------------------------------------------------------------------------------------------


# Create Plot 2
# -----------------------------------------------------------------------------------------------------------------------------------
png("plot2.png", width = 480,height = 480)
plot(x = PowerConsumptionDataSet$DateTime, y = PowerConsumptionDataSet$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)", cex.lab = 0.8, cex.axis = 0.8)
dev.off()
# -----------------------------------------------------------------------------------------------------------------------------------
