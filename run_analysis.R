# Getting and Cleaning Data - Course Project
# Step 1: Merge the training and the test sets to create one data set
# a. Download zipped folder into working directory
setwd("C:/Users/weijie/Desktop/Coursera R course/III. Getting and Cleaning data")
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileUrl,temp)
#b. Read and combine the data sets
dataTrain <- read.table(unz(temp,"UCI HAR Dataset/train/X_train.txt"))
dataTest <- read.table(unz(temp,"UCI HAR Dataset/test/X_test.txt"))
featureNames <- read.table(unz(temp,"UCI HAR Dataset/features.txt"))
IDTrain <- read.table(unz(temp,"UCI HAR Dataset/train/subject_train.txt"))
IDTest <- read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt"))
ActivityTrain <- read.table(unz(temp,"UCI HAR Dataset/train/y_train.txt"))
ActivityTest <- read.table(unz(temp,"UCI HAR Dataset/test/y_test.txt"))
unlink(temp)
CombinedData <- rbind(dataTrain,dataTest)
# Step 2: Extract only the measurements on the mean and standard dev for each measurement
CombinedData_extract <- matrix(,nrow=nrow(CombinedData),ncol=0)
n=1
featureNames_extract <- vector()
for(i in 1:nrow(featureNames)){
        if(((grepl("mean",featureNames[i,2]) | grepl("std",featureNames[i,2])) & !grepl("meanFreq",featureNames[i,2])) == TRUE){
                featureNames_extract[n] <- as.character(featureNames[i,2])
                n = n + 1
                CombinedData_extract <- cbind(CombinedData_extract,CombinedData[,i])
        }
}
# Step 3: Label data set with descriptive variable names 
for(j in 2:ncol(CombinedData_extract)){
        names(CombinedData_extract)[j] <- featureNames_extract[j-1]
}
# Step 4: Create a second independent TIDY data set, with the average of each variable for each activity and each subject
X1 <- rbind(IDTrain,IDTest)
X2 <- rbind(ActivityTrain,ActivityTest)
FullData <- cbind(X1,X2,CombinedData_extract)
names(FullData)[1] <- "ID"
names(FullData)[2] <- "Activity"
for(r in 3:68){
        names(FullData)[r] <- as.character(featureNames_extract[r-2])
}
library(reshape2)
AveData_full <- melt(FullData,id=c("ID","Activity"))
AveData <- dcast(AveData_full, ID + Activity ~ variable,mean)
AveData1 <- write.table(AveData, row.name=FALSE, file="AveOfVar.txt")