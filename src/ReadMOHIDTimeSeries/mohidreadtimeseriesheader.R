
mohidreadtimeseriesheader <- function(filename)
  
{
  
  buffer  = readLines(filename)
  btsline = grep("<BeginTimeSerie>", buffer)
  headerline = buffer[btsline-1]
  header =  mohidstrsplit(headerline)
      
  return(header)
                 
}

