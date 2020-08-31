setwd("C://Users//Wee Zi Feng//Documents//R//Git//Getting and Cleaning Data Course Project")

library(dplyr)
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "C://Users//Wee Zi Feng//Documents//R//Git//Getting and Cleaning Data Course Project//getdata_projectfiles_UCI_HAR_Dataset.zip")
unzip("getdata_projectfiles_UCI_HAR_Dataset.zip", exdir = getwd())

features <- as.character(read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//features.txt', header = FALSE)[,2])
subjecttrain = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//train//subject_train.txt',header=FALSE)
xtrain = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//train//X_train.txt',header=FALSE)
ytrain = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//train//y_train.txt',header=FALSE)
subjecttest = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//test//subject_test.txt',header=FALSE)
xtest = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//test//X_test.txt',header=FALSE)
ytest = read.table('~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//test//y_test.txt',header=FALSE)

#Merges the training and the test sets to create one data set.

traindata <-  data.frame(subjecttrain, ytrain, xtrain)
testdata <-  data.frame(subjecttest, ytest, xtest)
names(traindata) <- c(c('Person', 'activity'), features)
names(testdata) <- c(c('Person', 'activity'), features)

fulldata <- rbind(traindata, testdata)

#Extracts only the measurements on the mean and standard deviation for each measurement.

ext_data_mean_std <- grep(("mean\\(\\)|std\\(\\)"), features)
ext_data <- fulldata[,c(1,2,ext_data_mean_std+2)]

#Uses descriptive activity names to name the activities in the data set

activity <- read.table("~//R//Git//Getting and Cleaning Data Course Project//UCI HAR Dataset//activity_labels.txt",header = FALSE)
ext_data$activity <- factor(ext_data$activity, levels = activity[,1], labels = activity[,2])

#Appropriately labels the data set with descriptive variable names.

names(ext_data) <- gsub("Acc", "Accelerometer", names(ext_data))
names(ext_data) <- gsub("Gyro", "Gyroscope", names(ext_data))
names(ext_data) <- gsub("\\()", "", names(ext_data))
names(ext_data) <- gsub("-mean", "_Mean", names(ext_data))
names(ext_data) <- gsub("-std", "_StandardDeviation", names(ext_data))
names(ext_data) <- gsub("-", "_", names(ext_data))
names(ext_data) <- gsub("-std", "_StandardDeviation", names(ext_data))
names(ext_data) <- gsub("^f", "Frequency", names(ext_data))
names(ext_data) <- gsub("Mag", "Magnitude", names(ext_data))
names(ext_data) <- gsub("^t", "Time", names(ext_data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

TidyData <- aggregate(ext_data[,3:68], by = list(activity = ext_data$activity, subject = ext_data$Person),FUN = mean)
write.table(x = TidyData, file = "TidyData.txt", row.names = FALSE)

