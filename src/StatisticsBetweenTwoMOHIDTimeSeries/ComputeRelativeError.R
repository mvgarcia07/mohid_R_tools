ComputeRelativeError<- function(Observations, MOHID, StationName,
                                OutputFolder,PropertyName,PropertyUnit, writeStats=1){
  
  #find

  Observations_nlines = length(Observations$t)
  
  SelectedDataToCompare = data.frame(Observations$t,Observations$var,NA)
  names(SelectedDataToCompare) =c('Dates','Observations','Model')
  
  matchline_obs = match(strptime(Observations$t, format="%Y-%m-%d %H:%M:%S", tz='UTC'), 
                        strptime(MOHID$t, format="%Y-%m-%d %H:%M:%S", tz='UTC'),
                        nomatch = NA_integer_, incomparables = NULL)
  
  for (i in 1:Observations_nlines) {
    SelectedDataToCompare$Model[i]=MOHID$var[matchline_obs[i]]
  }
  
 #error per sampling
  for (i in 1:Observations_nlines){
    
    if(Observations$var[i] != 0.0){
      SelectedDataToCompare$RelativeError[i] = (SelectedDataToCompare$Model[i] - SelectedDataToCompare$Observations[i])/SelectedDataToCompare$Observations[i]
    }else{MOHID$RelativeError[i]=-999}
    
 }

ndigits =3
AverageError = round(mean(SelectedDataToCompare$RelativeError), digits = ndigits)
stdError     = round(sd(SelectedDataToCompare$RelativeError), digits = ndigits)
MaxError     = round(max(SelectedDataToCompare$RelativeError), digits = ndigits)
MinError     = round(min(SelectedDataToCompare$RelativeError), digits = ndigits)

if(writeStats==1){
  
  filename  = paste(OutputFolder,'/', StationName, '_', PropertyName, '_error.dat', sep='')
  write(paste('# ', StationName, ' Observations vs. Model',sep=''), file=filename)
  write(paste(PropertyName,' AverageError ', AverageError, sep=''), file=filename, append = TRUE)
  write(paste(PropertyName,' stdError ', stdError, sep=''), file=filename, append = TRUE)
  write(paste(PropertyName,' MaxError ', MaxError, sep=''), file=filename, append = TRUE)
  write(paste(PropertyName,' MinError ', MinError, sep=''), file=filename, append = TRUE)

}

return(SelectedDataToCompare)
} 

