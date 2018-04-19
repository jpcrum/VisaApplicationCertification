#Title: Jags-Model-2
#Author: Jack Crum
#Date: 4/13/2018

#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.

#------------------------------------------------------------------------------- 
# Read the data 
setwd("C:/Users/sjcrum/Documents/Bayesian Statistics/DataSets/Visas/Bayesian")

myData <- read.csv("CountryLogistic.csv") #Specifically converted dataframe for this model

set.seed(29)

fileNameRoot = "Visa-Country-logistic-" 
graphFileType = "jpg"

#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Model-1.R")

# Generate the MCMC chain:

mcmcCoda = genMCMC( datFrm=myData, yName="Certified", NName="Total", xName="Country", numSavedSteps=5000 , thinSteps=10 , saveName=fileNameRoot )


#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names for reference
for ( parName in c("b0","b[1]","omega[1]","kappa") ) { 
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
                saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , contrasts=contrasts ,
                        datFrm=myData, xName="Country",
                        #yName="Total", NName="Certified", 
                        saveName=fileNameRoot )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , contrasts=contrasts ,
          datFrm=myData, xName="Country", yName="Certified", NName="Total", 
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
