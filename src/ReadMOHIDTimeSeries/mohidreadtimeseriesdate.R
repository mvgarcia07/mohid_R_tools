mohidreadtimeseriesdate <- function(string)
  
{
  
  
  delimiterposition = regexpr(":",string)[1] 
  
  datestring = substring (string, delimiterposition+1, nchar(string))
  
  strdate = mohidstrsplit(datestring)
  
  year   = as.numeric(strdate[[1]][1])
  month  = as.numeric(strdate[[1]][2])
  day    = as.numeric(strdate[[1]][3])
  hour   = as.numeric(strdate[[1]][4])
  minute = as.numeric(strdate[[1]][5])
  second = as.numeric(strdate[[1]][6])
  
  timeseriesdate = timeCalendar(y=year, m=month, d=day, h=hour, min=minute, s=second)
  
  
  return(timeseriesdate)
  
} 
