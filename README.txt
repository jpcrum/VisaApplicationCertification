README.txt

Final Bayesian Project
Jack Crum
4/13/2018

There are multiple files in this project folder that were created during the running
of code or for specific purposes

The order the code should be run:

In main Visa folder:

1) CleaningEDA.Rmd
	- Loads, cleans, explores dataset and creates training and testing datasets

2) FrequentistModels.Rmd
	- Creates Logistic regression and XGBoost models


In Bayesian folder inside Visa Folder:

3) Jags-Model-2.R and Jags-Model-2-Example.R
	- Basic categorical JAGS hierarchical model
	- yName sets predicted variable, sName sets categorical predictor variable
	- Jags-Model-2.R contains the function building and JAGS model building
	- Jags-Model-2-Example.R sets the variables and runs the code to produce the posteriors
	- Jags-Model-2-Example.R sources Jags-Model-2.R

4) Jags-Model-1.R and Jags-Model-1-Example.R
	- Logistic Regression GLM JAGS hierarchical model for categorical
	- Takes specificly modified dataframe to work
	- Jags-Model-1.R contains the function building and JAGS model building
	- Jags-Model-1-Example.R sets the variables and runs the code to produce the posteriors
	- Jags-Model-1-Example.R sources Jags-Model-1.R
	- This model experiences an error but still returns the graph of all factor posteriors that I wanted.

5) Jags-Model-4.R and Jags-Model-4-Example.R
	- Logistic Regression GLM JAGS hierarchical model for multiple metric variables
	- yName sets predicted variable, xName sets predictor variables
	- Jags-Model-4.R contains the function building and JAGS model building
	- Jags-Model-4-Example.R sets the variables and runs the code to produce the posteriors
	- Jags-Model-4-Example.R sources Jags-Model-4.R
	- This models takes a fairly long time to run.


The results of the Bayesian models are in their respective folders in the Bayesian folder and the frequentist results are in the frequentist folder. 
Jags-Model-4.R results are in their specific labelled folder.

The Final Report is labelled as Final Report.doc and is located in the main Visa folder.

The presentation will be submitted separately.