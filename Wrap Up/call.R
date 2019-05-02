require(lubridate)


data <- read.csv(file = "C:\\Users\\Shivtej Patil\\Documents\\Call History\\Call History.csv", header = FALSE, sep = ",")


require(stringr)
#Select the rows which are only relelated to Mytaxi
data <- data %>% filter(str_detect(data$V1, "MyTaxi"))

require(dplyr)
# Remove Wrapup Code which are Non-Dialer Coll, Agent Skip, Agent Logout, Ambiguous
data <- data[(!data$V16 == "Non-Dialer Call" & !data$V16 == "Agent Skip" & !data$V16 == "Agent Logout" & !data$V16 == "Ambiguous"),]

dateeu <- data[, 4]

require(data.table)
#Convert DateTime format into the Date format 
dateeu <- as.Date(dateeu, format = "%d/%m/%Y %H:%M:%S")

callanstime<- data[,5]
callanstime <-as.Datetime(callanstime,format="%d/%m/%Y %H:%M:%S")

#Extract Timing From DataTime Datatype UTC Time Zome
callanstime <- as.ITime(as.POSIXct(callanstime, format = "%d/%m/%Y %H:%M:%S", tz = "UTC"))


