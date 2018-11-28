source('../../src/ReadMOHIDTimeSeries/mohidtimeseries.R')

source(paste('../../src/StatisticsBetweenTwoMOHIDTimeSeries/', 'PlotsMohidvsObservations.r', sep=''))
source(paste('../../src/StatisticsBetweenTwoMOHIDTimeSeries/', 'ComputeRelativeError.r', sep=''))

Folder_Analysis ='../../tools/StatisticsBetweenTwoMOHIDTimeSeries'
setwd(Folder_Analysis)

Folder_MOHIDOriginal = paste(Folder_Analysis, '/data',sep='')
Folder_Observations  = paste(Folder_Analysis, '/data',sep='')
OutputFolder         = paste(Folder_Analysis,'/output',sep='')

StationName = 'TestStation'
ObsName = 'ObservationsInFormatMOHIDTimeSerie_example.dat'
ResName = 'MOHIDTimeSerie_example.srh'

ObsFileName = paste(Folder_Observations,'/', ObsName, sep='')
ResFileName = paste(Folder_MOHIDOriginal,'/', ResName, sep='' )

PropertyObs   = c("VelC(cm/s)")
PropertyModel = c("velocity_modulus")

#Read observations and MOHID
factorObservations=0.01 #units are different between the time series
Observations = data.frame(mohidtimeseries(paste(ObsFileName, sep=''), PropertyObs,factorObservations))
Observations = Observations[Observations$var>0.0,]
names(Observations)=c('t','var')

MOHID = mohidtimeseries(ResFileName, PropertyModel)
  
#plot settings
PropertyName   = 'Velocity'
PropertyUnits  = 'm/s'
PropertyColors = c(2,3)
TherangeValue =c(0,8)
TherangeGrowth =c(0,2)


PlotMohid_1Run_WithObservations(Observations,MOHID,StationName, 
                            OutputFolder,PropertyName,PropertyUnits)

#match obs and model, select same points
SelectedDataToCompare = ComputeRelativeError(Observations, MOHID, StationName,
                                         OutputFolder,PropertyName,PropertyUnits)  

PlotMohid_1Run_Vs_Observations(SelectedDataToCompare,StationName, 
                           OutputFolder,PropertyName,PropertyUnits)

