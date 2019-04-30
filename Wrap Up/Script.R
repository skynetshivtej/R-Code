library(lubridate)

wrapup <- read.csv(file = "C:\\Users\\Shivtej Patil\\Documents\\Wrap Up Code\\wrapup.csv")
otherdata<- wrapup[, 1:5]
date <- wrapup[, 6]

# find out first day of week from date 
result <- data.frame(as.Date(date, format = "%d/%m/%Y %H:%M"), cut_Date = cut(as.Date(date, format = "%d/%m/%Y %H:%M"), format = "%d/%m/%Y %H:%M", "week"),
  cut_POSIXt = cut(as.POSIXct(date, format = "%d/%m/%Y %H:%M"), "week"),
    stringsAsFactors = FALSE)


abc <- cbind.data.frame(result, wrapup)


#Weekly Report 

ndvalue<- subset.data.frame(abc, abc$WrapupCode == 'NS')


ndvalue$WrapupCode <- 1

library(data.table)

ndvalue <- ndvalue %>% filter(str_detect(ndvalue$WorkgroupID, "Pinergy"))
print(ndvalue)
library(sqldf)

#finalda<- sqldf("select  *, sum(wrapupcode) from ndvalue where WorkgroupID like 'Pine%' group by 'as.Date.date..format.....d..m..Y..H..M..',icuserid  ;")


