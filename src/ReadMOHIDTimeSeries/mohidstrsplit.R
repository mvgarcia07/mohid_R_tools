mohidstrsplit <- function(string)
  
{
 
  
  strlength = nchar(string)
  
  strvector = c()
  
  i = 1
  n = 0
  firstchar = FALSE
  fillingname = FALSE
  
  for(i in 1:strlength){
    
    character = substring(string, i, i)
    
    if(character != " "){
      
      if(firstchar == TRUE){
        
        firstchar = FALSE
        fillingname = TRUE
        colname = paste0(colname, character)
        
      } else {
        
        if(fillingname == TRUE){
          
          colname = paste0(colname, character)
          
        } else {
          
          firstchar = TRUE
          n = n + 1
          colname = character
          fillingname = TRUE
        } 
        
      }   
      
    } else {
      
      if(fillingname){
        strvector[n] <- colname  
      }
      fillingname = FALSE
      firstchar = FALSE
      
    }  
    
  }
  
  if(character != " "){
    strvector[n] <- colname
  }
    
  
  return(list(strvector, n))
  
} 
