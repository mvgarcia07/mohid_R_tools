add_legend <- function(...,line) {
  opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
              mar=c(0, 0, 0, 0), new=TRUE)
  on.exit(par(opar))
  plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  legend(...)
}  


ltyList = c(1,2,1,2)
lwdList = c(1,1,3,3)
colList = c('black','black','black','black')
bgList = c('black','black','black','black')
pchList = c(21,21,22,22)

Ystep_Standard = '1 hour'
YFormat_Standard ='%HH'
#YFormat ='%Y-%m-%d'
#Ystep = '1 year'
#YFormat ='%Y-%m'

Ystep = '1 hour'
YFormat ='%HH'

library(plotrix)

PlotMohid_1Run_WithObservations<- function(Observations,MOHID,StationName, 
                                           OutputFolder,PropertyName,PropertyUnits, Ystep=0, YFormat=0)
  
{  
  
  if(Ystep==0){Ystep=Ystep_Standard}
  if(YFormat==0){YFormat=YFormat_Standard}
  
  plottitle = paste(StationName,sep='')
  plotSave  = paste(OutputFolder,'/', StationName, '_', PropertyName,sep='')
  
  windows(15,7)
  par(mar=c(4,4,5,4),family = 'serif')
  
  daterange= range(Observations$t)
  yrange   = range(Observations$var, MOHID$var)
  ygridby     = Ystep 
  
  plot(MOHID$t, MOHID$var,  
       xaxt ='n', 
       xlab = 'Time [d]',  
       ylab = paste(PropertyName,' ',PropertyUnits, sep=''),  
       cex.lab=1.2,
       type = "n",col = 'black', 
       bg='black', pch = 21, cex = 1.2,
       xlim = as.POSIXct(daterange),
       ylim = yrange
  )
  
  axis.POSIXct(1, at=seq(daterange[1], daterange[2], by=ygridby), format=YFormat, cex.axis=1,xlim = as.POSIXct(daterange)) 
  
  lines(MOHID$t, MOHID$var, type='l', lty=1, lwd =2, col = 'black', bg='black', pch = 21, cex = 1) 
  points(Observations$t, Observations$var,type='o', lty=2, lwd =0, col = 'black', bg='white', pch = 21, cex = 1) 
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }  
  
  add_legend (line = 1, "topright",lty=c(1,2),lwd =c(2,2), 
              c('Model', 'Observations'), 
              col=c('black', 'black'),
              pch = c(0,21), pt.bg=c('black', 'white'),
              pt.cex = c(0,1), 
              text.col =c('black'),bty='n',   
              cex =1.,horiz = FALSE) 
  
  title(main = plottitle, line =1, cex.main=2,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

PlotMohid_1Run_Vs_Observations<- function(SelectedDataToCompare,StationName, 
                                          OutputFolder,PropertyName,PropertyUnits)
  
{  
  plottitle = paste(PropertyName, ' at ', StationName, sep='')
  plotSave  = paste(OutputFolder,'/', StationName, '_', PropertyName, '_ModelvsObs',sep='')
  
  windows()
  par(mar=c(4,4,5,4),family = 'serif')
  
  xrange= range(SelectedDataToCompare$Model,SelectedDataToCompare$Observations)
  yrange   = range(SelectedDataToCompare$Observations)
  ygridby     = Ystep 
  
  plot(SelectedDataToCompare$Model, SelectedDataToCompare$Observations,  
       xlab = paste('Predicted ', sep=''),  
       ylab = paste('Observed ',sep=''), 
       cex.lab=1.2,
       type = "n",col = 'black', 
       bg='black', pch = 21, cex = 1.2,
       xlim = xrange,
       ylim = xrange
  )
  
  #abline(h=0, col = 'gray',lwd =0.5)
  #abline(v=0, col = 'gray',lwd =0.5)
  #shadow of 10%
  shadow=10/100
  
  p1=c(-2,-2-shadow)
  p2=c(2,2-shadow)
  p3=c(2,2+shadow)
  p4=c(-2,-2+shadow)  
  
  polygon(c(p1[1],p2[1],p3[1],p4[1]), c(p1[2],p2[2],p3[2],p4[2]), col="grey91",border = NA)
  abline(a=0,b=1, col="black", lty=1,lwd =3 )
  
  points(SelectedDataToCompare$Model, SelectedDataToCompare$Observations,type='o', lty=0, lwd =0, col = 'black', bg='white', pch = 21, cex = 1) 
  
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }  
  
  # add_legend (line = 1, "topright",lty=c(1,2),lwd =c(2,2), 
  #             c('Model', 'Observations'), 
  #             col=c('black', 'black'),
  #             pch = c(0,21), pt.bg=c('black', 'white'),
  #             pt.cex = c(0), 
  #             text.col =c('black'),bty='n',   
  #             cex =1.,horiz = FALSE) 
  
  title(main = plottitle, line =1, cex.main=2,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

PlotMohid_1Run_WithObservations_Taylor<- function(SelectedDataToCompare,StationName, 
                                                  OutputFolder,
                                                  PropertyName,PropertyUnits)
  
{ 
  
  plottitle = paste(StationName, ' ', PropertyName, sep='')
  plotSave  = paste(OutputFolder, '/', StationName, '_', PropertyName, '_Taylor', sep='')
  
  windows()
  par(mar=c(4,4,5,4),family = 'serif')
  
  taylor.diagram(SelectedDataToCompare$Observations,SelectedDataToCompare$Model,
                 col=c('white', "black"),pch=19,pos.cor=FALSE,
                 #xlab="standard deviation",ylab="standard deviation",
                 main=plottitle,
                 show.gamma=TRUE,ngamma=3,
                 gamma.col=8,sd.arcs=0,ref.sd=FALSE,sd.method="sample",
                 grad.corr.lines=c(0.2,0.4,0.6,0.8,0.9),
                 pcex=2,cex.axis=1,normalize=TRUE,mar=c(0,0,0,0))
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }  
  
  add_legend (line = -1, "topleft",lty=c(0,0,0),lwd =c(0,0,0), 
              c('Model', 'Observations', 'ModelPaulo'), 
              col=c('black', 'black','black'),
              pch = c(21,21, 21), pt.bg=c('black', 'white','orange'),
              pt.cex = c(1.3,1.3,1.3), 
              text.col =c('black'),bty='n',   
              cex =1.,horiz = FALSE) 
  
  #title(main = plottitle, line =1, cex.main=2,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

PlotMohid_2Run_WithObservations<- function(Observations,MOHID,StationName, 
                                           OutputFolder,PropertyName,PropertyUnits, Ystep=0, YFormat=0,ModeloPauloToCompare)
  
{  
  
  if(Ystep==0){Ystep=Ystep_Standard}
  if(YFormat==0){YFormat=YFormat_Standard}
  
  plottitle = paste(StationName, sep='')
  plotSave  = paste(OutputFolder,StationName, '_', PropertyName, '_', 'Paulo',sep='')
  
  windows(15,7)
  par(mar=c(4,4,5,4),family = 'serif')
  
  daterange= range(Observations$t)
  yrange   = range(Observations$var, MOHID$var, ModeloPauloToCompare$var)
  ygridby     = Ystep 
  
  plot(MOHID$t, MOHID$var,  
       xaxt ='n', 
       xlab = 'Time [d]',  
       ylab = paste(PropertyName,' ',PropertyUnits, sep=''),  
       cex.lab=1.2,
       type = "n",col = 'black', 
       bg='black', pch = 21, cex = 1.2,
       xlim = as.POSIXct(daterange),
       ylim = yrange
  )
  
  axis.POSIXct(1, at=seq(daterange[1], daterange[2], by=ygridby), format=YFormat, cex.axis=1,xlim = as.POSIXct(daterange)) 
  
  lines(MOHID$t, MOHID$var, type='l', lty=1, lwd =2, col = 'black', bg='black', pch = 21, cex = 1) 
  lines(ModeloPauloToCompare$t, ModeloPauloToCompare$var, type='l', lty=1, lwd =2, col = 'orange', bg='orange', pch = 21, cex = 1) 
  points(Observations$t, Observations$var,type='o', lty=2, lwd =0, col = 'black', bg='white', pch = 21, cex = 1) 
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }  
  
  add_legend (line = 1, "topright",lty=c(1,1),lwd =c(2,2), 
              c('Model', 'Model Paulo', 'Observations'), 
              col=c('black', 'orange','black'),
              pch = c(0,0,21), pt.bg=c('black', 'black', 'white'),
              pt.cex = c(0,0,1), 
              text.col =c('black'),bty='n',   
              cex =1.,horiz = FALSE) 
  
  title(main = plottitle, line =1, cex.main=2,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

PlotMohid_2Run_Vs_Observations<- function(SelectedDataToCompare,StationName, 
                                          OutputFolder,PropertyName,PropertyUnits,SelectedPauloToCompare)
  
{  
  plottitle = paste(PropertyName, ' at ', StationName, ' ', sep='')
  plotSave  = paste(OutputFolder,'/', StationName, '_', PropertyName, '_ModelvsObsPaulo',sep='')
  
  windows()
  par(mar=c(4,4,5,4),family = 'serif')
  
  xrange= range(SelectedDataToCompare$Model,SelectedDataToCompare$Observations)
  yrange   = range(SelectedDataToCompare$Observations)
  ygridby     = Ystep 
  
  plot(SelectedDataToCompare$Model, SelectedDataToCompare$Observations,  
       xlab = paste('Predicted ', sep=''),  
       ylab = paste('Observed ',sep=''), 
       cex.lab=1.2,
       type = "n",col = 'black', 
       bg='black', pch = 21, cex = 1.2,
       xlim = xrange,
       ylim = xrange
  )
  
  #abline(h=0, col = 'gray',lwd =0.5)
  #abline(v=0, col = 'gray',lwd =0.5)
  #shadow of 10%
  shadow=10/100
  
  p1=c(-2,-2-shadow)
  p2=c(2,2-shadow)
  p3=c(2,2+shadow)
  p4=c(-2,-2+shadow)  
  
  polygon(c(p1[1],p2[1],p3[1],p4[1]), c(p1[2],p2[2],p3[2],p4[2]), col="grey91",border = NA)
  abline(a=0,b=1, col="black", lty=1,lwd =3 )
  
  points(SelectedDataToCompare$Model, SelectedDataToCompare$Observations,type='o', lty=0, lwd =0, col = 'black', bg='white', pch = 21, cex = 1) 
  points(SelectedPauloToCompare$Model, SelectedDataToCompare$Observations,type='o', lty=0, lwd =0, col = 'black', bg='orange', pch = 21, cex = 1) 
  
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5),
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }
  # 
  add_legend (line = -2.5, "topright",lty=c(0,0),lwd =c(0,0),
              c('Model', 'Model Paulo'),
              col=c('black', 'orange'),
              pch = c(21,21), pt.bg=c('white', 'orange'),
              pt.cex = c(1,1),
              text.col =c('black'),bty='n',
              cex =1.2,horiz = FALSE)
  
  title(main = plottitle,line =3, cex.main=1.5,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

PlotMohid_2Run_WithObservations_Taylor<- function(SelectedDataToCompare,StationName, 
                                                  OutputFolder,
                                                  PropertyName,PropertyUnits,SelectedPauloToCompare,
                                                  Ystep=0, YFormat=0)
  
{  
  
  plottitle = paste(StationName, ' ', PropertyName, sep='')
  plotSave  = paste(OutputFolder, StationName, '_', PropertyName, '_Taylor_', sep='')
  
  windows()
  par(mar=c(4,4,5,4),family = 'serif')
  
  taylor.diagram(SelectedDataToCompare$Observations,SelectedDataToCompare$Model,
                 col=c('white', "black"),pch=19,pos.cor=FALSE,
                 #xlab="standard deviation",ylab="standard deviation",
                 main=plottitle,
                 show.gamma=TRUE,ngamma=3,
                 gamma.col=8,sd.arcs=0,ref.sd=FALSE,sd.method="sample",
                 grad.corr.lines=c(0.2,0.4,0.6,0.8,0.9),
                 pcex=2,cex.axis=1,normalize=TRUE,mar=c(0,0,0,0))
  
  # now add model2
  taylor.diagram(SelectedDataToCompare$Observations,SelectedPauloToCompare$Model,
                 add=TRUE,
                 col="orange",pch=19,pos.cor=FALSE,
                 show.gamma=TRUE,ngamma=3,
                 gamma.col=8,sd.arcs=0,ref.sd=FALSE,sd.method="sample",
                 pcex=2,cex.axis=1,normalize=TRUE)
  
  par(xpd=NA)   
  
  # add_legend <- function(...,line) {
  #   opar <- par(fig=c(0, 1, 0, 1), oma=c(5, 5, 4+line, 5), 
  #               mar=c(0, 0, 0, 0), new=TRUE)
  #   on.exit(par(opar))
  #   plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n', xlab='',ylab='')
  #   legend(...)
  # }  
  
  add_legend (line = -1, "topleft",lty=c(0,0,0),lwd =c(0,0,0), 
              c('Model', 'Observations', 'ModelPaulo'), 
              col=c('black', 'black','black'),
              pch = c(21,21, 21), pt.bg=c('black', 'white','orange'),
              pt.cex = c(1.3,1.3,1.3), 
              text.col =c('black'),bty='n',   
              cex =1.,horiz = FALSE) 
  
  #title(main = plottitle, line =1, cex.main=2,lty=1, lwd =2)
  savePlot(plotSave,type='png',device = dev.cur())         
  savePlot(plotSave,type='pdf',device = dev.cur())         
  
  dev.off()
}# end function   

