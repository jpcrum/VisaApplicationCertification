
graphics.off() 
rm(list=ls())  

setwd("C:/Users/sjcrum/Documents/Bayesian Statistics/DataSets/Visas")
#------------------------------------------------------------------------------- 

# Load data file and specity column names of x (predictor) and y (predicted):
myData = read.csv( file="training.csv" )
xName = "pw_amount_9089" ; yName = "employer_num_employees"
fileNameRoot = "Visa-Jags-" 

graphFileType = "jpg" 
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Model-3.R")
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
#startTime = proc.time()
mcmcCoda = genMCMC( data=myData , xName=xName , yName=yName , 
                    numSavedSteps=20000 , saveName=fileNameRoot )
#stopTime = proc.time()
#duration = stopTime - startTime
#show(duration)
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names
for ( parName in parameterNames ) {
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
            saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , 
                        compValBeta1=0.0 , ropeBeta1=c(-0.5,0.5) ,
                        saveName=fileNameRoot )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , xName=xName , yName=yName , 
          compValBeta1=0.0 , ropeBeta1=c(-0.5,0.5) ,
          pairsPlot=TRUE , showCurve=FALSE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
