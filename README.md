## Instructions for the RunAnalysis.R Script

## Requirements
* The "UCI HAR Dataset" folder must be in the working directory
* The "reshape2" package must be installed

## Description
The script first loads the reshape2 package and all of the required datasets from the UCI HAR Datset folder.
Then a filter is created to limit the data to only the means and standard deviations. After the filter is applied
to the training and test datasets, the two sources of data are combined. The script then calculates the averages for each
activity and then exports the resulting table to the working directory. 