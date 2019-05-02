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

callanstime <- data[, 5]


#Extract Timing From DataTime Datatype UTC Time Zome Call Answered 
callanstime <- strptime(x = as.character(data$V8), format = "%d/%m/%Y %H:%M:%S",tz= "UTC")

#Extract Timing From DataTime Datatype UTC Time Zome Call Disconnected 
calldistime <- data[, 8]

calldistime <- strptime(x = as.character(data$V5), format = "%d/%m/%Y %H:%M:%S", tz = "UTC")

# Change logical values into integer for better mathemathical operations 
data$V11 <- as.integer(as.logical(data$V11))
data$V12 <- as.integer(as.logical(data$V12))


V16 <- c("Driver on Leave", "Not Interested", "No longer a Taxi Driver", "Incorrect Number", "Do Not Contact", "Agreed to Increase Usage", "Agreed to Register / Re - Activate",
                     "No Answer", "DMC Scheduled Callback", "Non DMC Scheduled Callback", "Agent Skip", "Wrong Party", "NS", "Customer Disconnected", "DMC Manual Callback", "Registered / Reactivated",
                     "Happy with mytaxi - No Customers in Area", "Non - Dialer Call", "Issue with T & Cs", "Non DMC Manual Callback", "Reactivated", "Registered", "Customer Query",
                     "Passenger Issue", "Passenger Query", "Payment Issue", "App Issue", "General Information", "Currently Using MyTaxi App", "Topaz Query", "Acquisition - New", "Acquisition - 3 T",
                     "Acquisition - 100 T", "Reactivation - New", "Reactivation - 3 T", "Reactivation - 100 T", "Issue with Fare")

Contact <- c(1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
DMC <- c(1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
Sale <- c(0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0)

data <- cbind(data, dateeu, callanstime, calldistime)

dmcsaltable <- data.frame(Localizedwrapup, Contact, DMC, Sale)

require(sqldf)

data <- sqldf("select * from data join dmcsaltable on V16 = Localizedwrapup")


