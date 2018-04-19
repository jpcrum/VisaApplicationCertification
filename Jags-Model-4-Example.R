#Title: Jags-Model-2
#Author: Jack Crum
#Date: 4/13/2018

#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.

library(dplyr)
#------------------------------------------------------------------------------- 

# # Two predictors:

setwd("C:/Users/sjcrum/Documents/Bayesian Statistics/DataSets/Visas")

#Reading in whole dataset
Data <- read.csv( file="training.csv" )

#Set for reproducibility
set.seed(29)
# Sample out 20000 observations to make model runable
myData <- sample(Data[sample(nrow(Data), 20000), ])

 
#y = predicted variable, x = predictor variables
yName = "case_status" ; xName = c("pw_amount_9089","employer_num_employees")
fileNameRoot = "training-robust-met" 
numSavedSteps=5000 ; thinSteps=2
# #.............................................................................

graphFileType = "jpg" 

#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory
setwd("C:/Users/sjcrum/Documents/Bayesian Statistics/DataSets/Visas/Bayesian")
source("Jags-Model-4.R")

#------------------------------------------------------------------------------- 
# Generate the MCMC chain:

mcmcCoda = genMCMC( data=myData , xName=xName , yName=yName , 
                    numSavedSteps=numSavedSteps , thinSteps=thinSteps , 
                    saveName=fileNameRoot )

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
                        saveName=fileNameRoot )
show(summaryInfo)
# Display posterior information:

plotMCMC( mcmcCoda , data=myData , xName=xName , yName=yName , 
          pairsPlot=TRUE , showCurve=FALSE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
