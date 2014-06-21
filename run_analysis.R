# This script runs an analysis on the UCI HAR dataset
# and produces a single data.frame consisting of both Training and Test Data. 
# only mean and standard deviation values are included in the merge
#
# Author: Mikkel Porse Rasmussen
# Data  : June 21st, 2014

# make sure data is available
if(!file.exists("test") | !file.exists("train"))
  stop("Data not found. Maybe you need to switch working directory?!")

# read the featurelist
features <- scan("features.txt", what="",sep="\n",quiet=T)

# we only want the mean- and std-h features, so get those
meanAndStdFeatures <- grepl("mean|std", features)

# Extract names. Replace prefixed numbers and inline parethesis while we're at it
meanAndStdFeatureNames <-  features[meanAndStdFeatures]

# make the labels more readable by 
# - removing the prefixed numbers 1 through 561
# - replacing prefixed 't' and 'f' with 'TIME' and FREQUENCY'
# - replacing '-' with '_'
meanAndStdFeatureNames <- gsub("^\\d{1,3} |\\(\\)","",meanAndStdFeatureNames)
meanAndStdFeatureNames <- gsub("^f","FREQUENCY_", meanAndStdFeatureNames)
meanAndStdFeatureNames <- gsub("^t","TIME_", meanAndStdFeatureNames)
meanAndStdFeatureNames <- gsub("\\-","_", meanAndStdFeatureNames)

# construct a column-filter - no reason to read columns we're not going to need
colFilter <- mapply(ifelse, meanAndStdFeatures, "numeric", "NULL")

# read the activities names
activities <- read.table("activity_labels.txt",as.is=T)$V2

# Read data from testfolder
setwd("test")
testData <- read.table("X_test.txt", colClasses=colFilter)
testSubjects <- read.table("subject_test.txt")
testActivity <- list(act=activities[read.table("y_test.txt")$V1]) # get the activity names

#read training data
setwd("../train")
trainData <- read.table("X_train.txt",colClasses=colFilter)
trainSubjects <- read.table("subject_train.txt")
trainActivity <- list(act=activities[read.table("y_train.txt")$V1])

# get back to parent folder
setwd("..")

# construct a data.frame from the test and training data
mergedData <- as.data.frame(
  rbind( # rows from training data and test data
    cbind(trainSubjects, trainActivity, trainData), # columns from subject, activity, measurements
    cbind(testSubjects, testActivity, testData)
    ))

# And construct a tidy dataset consisting of the average values by subject and activity
tidySet <- aggregate(x=mergedData[,3:81],by=list(mergedData$Subject, mergedData$Activity),FUN=mean)

# and assign the better column names
names(tidySet)<-c("Subject", "Activity",meanAndStdFeatureNames)

# clean up memory
rm(mergedData, testData, testSubjects, trainData, trainSubjects)
rm(activities, colFilter, features, meanAndStdFeatures, meanAndStdFeatureNames, testActivity, trainActivity)

