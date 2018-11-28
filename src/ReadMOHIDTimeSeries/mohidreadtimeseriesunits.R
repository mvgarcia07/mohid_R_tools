mohidreadtimeseriesunits <- function(string)
  
{
    
  delimiterposition = regexpr(":",string)[1] 
  
  unitsstring       = substring (string, delimiterposition+1, nchar(string))
  
  strunits          = mohidstrsplit(unitsstring)
   
  return(strunits[[1]])
  
} 
