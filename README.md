# clean_data_repo
Getting and Cleaning Data Course Project Repo

This data is from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The background information is at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

####Assignment Text
The code run_analysis.R does the following
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
#### how to run the analysis
1. download the .zip file
2. unzip the file into a main directory: "getdata_projectfiles_UCI HAR Dataset"
3. place run_analysis.R in the directory housing "getdata_projectfiles_UCI HAR Dataset"
4. in R: source("run_analysis.R")
5. the output will be in "tidy_data_table.txt" in the same directory