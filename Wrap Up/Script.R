library(lubridate)

wrapup <- read.csv(file = "C:\\Users\\Shivtej Patil\\Documents\\Wrap Up Code\\wrapup.csv")
otherdata<- wrapup[, 1:6]
date <- wrapup[, 6]

# find out first day of week from date 
result <- data.frame(as.Date(date, format = "%d/%m/%Y %H:%M"), cut_Date = cut(as.Date(date, format = "%d/%m/%Y %H:%M"), format = "%d/%m/%Y %H:%M", "week"),
  cut_POSIXt = cut(as.POSIXct(date, format = "%d/%m/%Y %H:%M"), "week"),
    stringsAsFactors = FALSE)


abc <- cbind.data.frame(result, wrapup)


#Weekly Report 

ndvalue<- subset.data.frame(abc, abc$WrapupCode == 'NS')

print(ndvalue$cut_Date,mutate(nostatus %>% group_by(nostatus$icuserid) %>% summarise(count = n())))

BEGIN
SET NOCOUNT ON;
DECLARE@query nvarchar(max) =
    N 'SELECT top(5000) a.[InteractionIDKey]
     ,[UserID]
     
      ,cast([WrapupStartDateTimeUTC] as datetime) 
	 
	   
      FROM [Core].[dbo].[InteractionSummary] a JOIN [Core].[dbo].[InteractionWrapup] b ON a.InteractionIDKey = b.InteractionIDKey; '
EXECUTE sp_execute_external_script@language = N 'R',
                                     @script = N '  
library(lubridate)
data =InputDataSet
date <- data[,3]

result <- data.frame(as.Date(date, format = "%d/%m/%Y %H:%M",tz="GMT"), cut_Date = cut(as.Date(date, format = "%d/%m/%Y %H:%M",tz="GMT"), "week"),
    cut_POSIXt = cut(as.POSIXct(date, format = "%d/%m/%Y %H:%M",tz="GMT"), "week"),
    stringsAsFactors = FALSE)

	finaldata <- merge(data,result)
OutputDataSet = finaldata
print(colnames(OutputdataSet))
',

@input_data_1 = @query
with result SETS((intid varchar(50), useid varchar(50), expr varchar(50), cut date, da date, pot date))

END





