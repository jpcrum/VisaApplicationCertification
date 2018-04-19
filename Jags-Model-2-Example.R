#Title: Jags-Model-2
#Author: Jack Crum
#Date: 4/13/2018
#------------------------------------------------------------------------------- 
# Read The data file:
setwd("C:/Users/sjcrum/Documents/Bayesian Statistics/DataSets/Visas/Bayesian")


myData = read.csv("training.csv")
yName = "case_status" # column name for 0,1 values
sName = "employer_state" # categorical column name for subject ID, can be changed

#File root name
fileNameRoot = "Jags-Visa-Omega-Kappa-Newspaper" 
graphFileType = "jpg" 
#------------------------------------------------------------------------------- 

#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Model-2.R")
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
mcmcCoda = genMCMC( data=myData , sName=sName , yName=yName , 
                    numSavedSteps=20000 , saveName=fileNameRoot , thinSteps=10 )
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names for reference
for ( parName in parameterNames[c(1:3,length(parameterNames))] ) { 
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
                saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , compVal=0.5 , 
                        # Compare California, DC, Mississippi, Texas, and Virginia
                        diffIdVec=c(5,8,26,45,47),   
                        compValDiff=0.0 ,
                        saveName=fileNameRoot )
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , sName=sName , yName=yName , 
          compVal=0.5 , 
          diffIdVec=c(5,8,26,45,47),              
          compValDiff=0.0, #ropeDiff = c(-0.05,0.05) ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
