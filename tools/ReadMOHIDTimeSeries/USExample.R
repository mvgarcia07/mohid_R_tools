setwd("./")

library(timeDate)
Sys.setenv(TZ='GMT')
source('../../src/ReadMOHIDTimeSeries/mohidstrsplit.R')
source('../../src/ReadMOHIDTimeSeries/mohidreadtimeseriesdate.R')
source('../../src/ReadMOHIDTimeSeries/mohidreadtimeseriesunits.R')
source('../../src/ReadMOHIDTimeSeries/mohidreadtimeseriesheader.R')
source('../../src/ReadMOHIDTimeSeries/mohidtimeseries.R')
source('../../src/ReadMOHIDTimeSeries/mohidunitsfactor.R')

timeseries = mohidtimeseries('./data/MOHIDTimeSerie_example.srh', "velocity_U")

t = timeseries$t
y = timeseries$var

