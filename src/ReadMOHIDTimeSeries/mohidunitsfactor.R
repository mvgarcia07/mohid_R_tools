
mohidunitsfactor <- function(timeunits) 
  
{
  
  if(timeunits == "SECONDS"){
    unitsfactor     = 1.
  } else if (timeunits == "MINUTES"){
    unitsfactor     = 60.
  } else if (timeunits == "HOURS"){
    unitsfactor     = 3600.
  } else if (timeunits == "DAYS"){
    unitsfactor     = 86400.
  }
      
  return(unitsfactor)
  
}
