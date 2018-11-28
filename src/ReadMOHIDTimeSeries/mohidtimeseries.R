library(timeDate)
Sys.setenv(TZ='GMT')

source(paste('../../src/ReadMOHIDTimeSeries/', 'mohidstrsplit.R', sep=''))
source(paste('../../src/ReadMOHIDTimeSeries/', 'mohidreadtimeseriesdate.R', sep=''))
source(paste('../../src/ReadMOHIDTimeSeries/', 'mohidreadtimeseriesunits.R', sep=''))
source(paste('../../src/ReadMOHIDTimeSeries/', 'mohidreadtimeseriesheader.R', sep=''))
source(paste('../../src/ReadMOHIDTimeSeries/', 'mohidunitsfactor.R', sep=''))

mohidtimeseries <- function(filename, colname, factor=1,Timelag=0) 
  
{
  buffer          = readLines(filename)
  nlines          = length(readLines(filename)) 
  
  initialdateline = grep("SERIE_INITIAL_DATA", buffer)  
  strinitialdate  = buffer[initialdateline]  
  initialdate     = mohidreadtimeseriesdate(strinitialdate)-Timelag*3600
  
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
      column = icol
    }    
  }
  
  nlines          = etsline-btsline-1
  timedata        <- vector(mode = "double", length = nlines)
  class(timedata) <- "POSIXct"
  vardata         <- vector(mode = "double", length = nlines)
  
  btsline = btsline
  etsline = etsline
  i       = 1
  
  unitsfactor = mohidunitsfactor(timeunits)
  
  fulldata <- matrix(scan(filename, skip = btsline, n = ncols*nlines, quiet = TRUE), ncols, nlines, byrow = FALSE)
  
  timedata = initialdate + fulldata[1,]*unitsfactor
  vardata  = fulldata[column,]

  return(list("t" = timedata, "var" = vardata * factor))
  
}
