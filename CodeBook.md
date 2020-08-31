---
title: "CodeBook"
output: html_document
---


## Code Book for the dataset

This is a document that describes the key variables and the work done to clean up the data . 

## Data transformation

The following variables are assigned to read the different files in the provided dataset zip folder.
1. features 
2. subjecttrain
3. xtrain 
4. ytrain 
5. subjecttest
6. xtest 
7. ytest

To merge the different training and test datasets to create one single data set, using the above varables and data.frame function to combine the data together while adding names to the column headers. fulldata is the complete merged dataset.

1.traindata 
2.testdata 
3.fulldata 

Next use grep function to search for column header that have mean and standard deviation and assign it to ext_data_mean_std.
Keep only these measurements in the assigned variable ext_data.

1. ext_data_mean_std
2. ext_data

Next using gsub to repalce the labels that are vague with clearer labels. For example, replace "Acc" with "Accelerometer" etc.

Lastly, create a new independent text file called TinyData.txt that contains the mean of each variable and each activity for the 30 individual persons. Save this data into a text file in the same working directory.

1. TidyData
2. TidyData.txt


