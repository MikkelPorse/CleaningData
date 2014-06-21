##Getting and Cleaning Data - Course Project
This repository contains 
- this README.MD
- run_analysis.R, the R script that generates 
- tidy_data.csv.txt, 
- codebook.MD

###run_analysis.R
The R script that generates the tidy_data.csv.txt file.
It reads the raw data from the UCI HAR dataset, http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
, reduces 561 measurements (and derivations) to 81, by only selecting mean- and standard deviation measurements. It merges the training
and test parts into one, groups the measurements by Subject and Activity, and computes the 
average of the measurements for each group. The result is output into the variable "tidySet"

Data is read as-is from the UCI HAR dataset, averaging over subject and activity is the only data transformation applied.
Features have been renamed however. 't' and 'f'-prefixes have been expanded to 'TIME' and 'FREQUENCY' respectively, 
hyphens have been replaced with underscores and parentheses have been removed.

Every variable is in one column, each observation is in a separate row and data are all of the same kind, and as such the output
conforms with our notion of tidyness.

usage:
- download script,
- set working directory to the "UCI HAR dataset" folder
- run script
- output is a variable tidySet with 180 observations and 81 variables

###tidy_data.csv.txt
The output of run_analysis.R saved to csv, using the command
write.csv(tidySet, file="tidy_data.csv.txt", row.names=F)

This file contains a summarized, tidy dataset based on the Samsung UCI HAR dataset.
Data is a comma separated list of measurement averages, grouped by subject and activity


##codebook.MD
This file describes the individual columns in the tidySet / tidy_data.csv.txt.
