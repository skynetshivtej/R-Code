require(lubridate)


data <- read.csv(file = "C:\\Users\\Shivtej Patil\\Documents\\Call History\\Call History.csv", header = FALSE, sep = ",")

require(dplyr)

#Select the rows which are only relelated to Mytaxi
data <- data %>% filter(str_detect(data$V1, "MyTaxi"))

# Remove Wrapup Code which are Non-Dialer Coll, Agent Skip, Agent Logout, Ambiguous
data <- data[(!data$V16 == "Non-Dialer Call" & !data$V16 == "Agent Skip" & !data$V16 == "Agent Logout" & !data$V16 == "Ambiguous"),]


#Convert DateTime format into the Date format 
dateeu <- as.Date(dateeu, format = "%d/%m/%Y %H:%M:%S")

