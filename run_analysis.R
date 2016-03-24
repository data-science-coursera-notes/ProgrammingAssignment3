# Programming Assignment: Getting and Cleaning Data Course Project
# By edgetrader
# 22 Mar 2016

# Loading the necessary packages and libraries
install.packages(stringr)
install.packages(data.table)
install.packages(dplyr)
library(stringr)
library(data.table)
library(dplyr)

# Load and understand the features.  
# Observed that there are a total of 561 variables observation.  This number should match with the ncol of
# the train and test data

feature <- read.table("UCI HAR Dataset/features.txt")


# To pick only the variables of the feature vector that are required for this project: mean() and std()
## There are 66 variables with mean and std

reqFeature <- rbind(feature[grepl('([Mm]ean\\(\\))',feature$V2),],feature[grepl('([Ss]td\\(\\))',feature$V2),])
colnames(reqFeature) <- c('index','name')


# Format and selecting the required variables and populate them in ReqMeasure with descriptive column names.  
# The column names are formatted in a way by considering the following properties in order (left to right):
#   1) t or f           (t for Time, f for Frequency)
#   2) Gravity or Body
#   3) Acc or Gyro      (Acc for Accelerometer, Gyro for Gyroscope)
#   4) Jerk             (ignore if not required)
#   5) Mean or Std
#   6) X, Y, Z or M     (X, Y and Z for 3 dimensional signals.  
#                        M for Magnitude calculated based on X,Y,Z using the Euclidean form)

reqFeature$name <- str_replace(reqFeature$name,"\\(\\)","")
reqFeature$name <- str_replace_all(reqFeature$name,"-","")
reqFeature$name <- str_replace_all(reqFeature$name,"mean","Mean")
reqFeature$name <- str_replace_all(reqFeature$name,"std","Std")
reqFeature$name <- str_replace_all(reqFeature$name,"BodyBody","Body")
reqFeature$name <- str_replace_all(reqFeature$name,"MagMean","MeanM")
reqFeature$name <- str_replace_all(reqFeature$name,"MagStd","StdM")


# Load in the activity labels.  Observed that there are a total of 6 activities as indicated in the Project
# readme file (ie WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

activity <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c('index','activity')


# Load in the train and test VARIABLE data.  Observed that Xtrain and Xtest have 561 variables that matches
# the number of observations in the number of variables in the feature vector

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

# Load the ACTIVITY type train and test data corresponding to each test record.
# Each activity is given a number 1 to 6.  Refer to activity_labels for description

ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

# Load the SUBJECT train and test data corresponding to each test record.  
# There is a total of 30 voluteers performing the tests.
# Each subject refers to one voluteer taking the test.  
# Each subject is given a number 1 to 30.

subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt")


## Reduce the scope of Xtrain and Xtest by selecting only the mean and std variables from train and test data.
## There are 66 variables with mean and std

Xtrain <- Xtrain[,reqFeature$index]
Xtest <- Xtest[,reqFeature$index]


# Update with tables with descriptive column names

colnames(Xtrain) <- reqFeature$name
colnames(Xtest) <- reqFeature$name
colnames(subtrain) <- "subject"
colnames(subtest) <- "subject"
colnames(ytrain) <- "activity"
colnames(ytest) <- "activity"


# Combine the 3 data table for train and test respectively

train <- cbind(subtrain, ytrain, Xtrain)
test <- cbind(subtest, ytest, Xtest)

# Combine the test and train data table to complete the tidy data set

tidydata <- rbind(train, test)

# Set subject and activity as factors in tidydata table.  

tidydata$subject <- factor(tidydata$subject)
tidydata$activity <- factor(tidydata$activity, levels = activity$index, labels = activity$activity)

    ## Check that there are 180 unique subject and activity pairs.
    ## length(unique(paste0(tidydata$subject,tidydata$activity)))
    ## There are 30 subjects performing 6 activities.  Hence 180 unique pairs.


# Create finaltidy table with the average of each variable for each activity and each subject
# There should be 180 records in the finaltidy table for 180 unique subject ~ activity pairs

tidydataBySubAct <- group_by(tidydata,subject,activity)
finaltidy <- summarize_each(tidydataBySubAct, funs(mean))
finaltidy <- arrange(finaltidy, subject, activity)
write.table(finaltidy, "tidy.txt", row.names = FALSE)


