
mohidtimeseries2 <- function(filename, colname)
  
{
  buffer          = readLines(filename)
  nlines          = length(readLines(filename)) 
  
  initialdateline = grep("SERIE_INITIAL_DATA", buffer)  
  strinitialdate  = buffer[initialdateline]  
  initialdate     = mohidreadtimeseriesdate(strinitialdate)
  
  timeunitsline   = grep("TIME_UNITS", buffer)  
  strtimeunits    = buffer[timeunitsline]
  timeunits       = mohidreadtimeseriesunits(strtimeunits)
  
  
  btsline         = grep("<BeginTimeSerie>", buffer)
  etsline         = grep("<EndTimeSerie>",   buffer)
  headerline      = buffer[btsline-1]
  header          = mohidstrsplit(headerline)
  
  colnames        = header[[1]]
  ncols           = header[[2]] 
  
  for(icol in 1:ncols){
    if(colname == colnames[[icol]]){
      col = icol
    }    
  }
  
  nlines          = etsline-btsline-1
  timedata        <- vector(mode = "double", length = nlines)
  class(timedata) <- "POSIXct"
  vardata         <- vector(mode = "double", length = nlines)
  
  btsline = btsline
  etsline = etsline
  i       = 1
  
  if(timeunits == "SECONDS"){
    unitsfactor     = 1.
  } else if (timeunits == "MINUTES"){
    unitsfactor     = 60.
  } else if (timeunits == "HOURS"){
    unitsfactor     = 3600.
  } else if (timeunits == "DAYS"){
    unitsfactor     = 86400.
  }
  
  fulldata <- matrix(scan(filename, skip = btsline, n = ncols*nlines, quiet = TRUE), ncols, nlines, byrow = FALSE)
  
  timedata = initialdate + fulldata[1,]*unitsfactor
  vardata  = fulldata[col,]
  
  return(list(timedata, vardata))
  
}
