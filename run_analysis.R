# setwd("c:/users/acongdon3/Documents/Coursera/3 course/clean_data_repo")
#data from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#source("run_analysis.R")
#Part 1: Merges the training and the test sets to create one data set.
#first figure out the names of the features - this will be used to label the data set
features_file <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
features <- read.table(features_file) #labels for the columns
feature_temp <- vector("character", length=ncol(features))
feature_temp <- as.character(features[,2])

#file names for training and test data
train_data <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
train_labels <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"
train_subjects <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"

test_data <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
test_labels <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"
test_subjects <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"

#load in the training set including data, activity and subject - give it col names as it goes
train_dataTable <- read.table(train_data, col.names=feature_temp)
activity_numTable <- read.table(train_labels, col.names="activity_num")
train_subjectTable <- read.table(train_subjects, col.names="subject_num")

#combine training data, subject number, and activity number into one table
train_dataTable <- cbind(train_subjectTable, train_dataTable, activity_numTable)

#load in the testing set - repeat process of combinging data, subject, and activity
test_dataTable <- read.table(test_data, col.names=feature_temp)
test_actTable <- read.table(test_labels, col.names="activity_num")
test_subjectTable <- read.table(test_subjects, col.names="subject_num")

#combine training into one data set
test_dataTable <- cbind(test_subjectTable, test_dataTable, test_actTable)

#now make huge data table of training and testing
combo_table <- rbind(test_dataTable, train_dataTable)

#save this combined data table - for debugging purposes 
write.table(combo_table, file="combo_table_all.txt")

#part 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#load in the big table
big_table_name <- "./combo_table_all.txt"
big_table <- read.table(big_table_name)

#find idx of columns with labels that contain mean and std 
find_mean_std <- grep("mean|std", labels(big_table)[[2]])
#add to the index 1 for the first column (subject number) add also the number of last column (activity number)
find_mean_std <- c(1, find_mean_std, ncol(big_table))

#make a smaller table of mean & std data + the subject number and the activity number
mean_std_table <- big_table[,find_mean_std]

#part 3: Uses descriptive activity names to name the activities in the data set
#add a column that shows the name based on the activity number 

#load in activity labels
activity_file <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
activity_names <- read.table(activity_file)
activity_names <- as.character(activity_names[,2])

#make a vector that has activity label that corresponds to activity number
activity_name <- vector("character", length=nrow(mean_std_table))
for (i in 1:length(activity_names))
{
  activity_name[grep(i, mean_std_table[,"activity_num"])] <- activity_names[i]
}

#add the activity labels to the table
mean_std_table <- cbind(mean_std_table, activity_name)

#part 4: Appropriately labels the data set with descriptive variable names. 
#already done above - columns have titles


#part 5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

#find the number of subjects
subjects <- unique(mean_std_table$subject_num)
subjects <- sort(subjects)

#find the number of activities
activities <- sort(unique(mean_std_table$activity_num))

total_rows <- length(subjects)*length(activities)

#figure out the labels for each piece of data
labeltemp <- labels(mean_std_table)[[2]]
labeltemp <- labeltemp[2:80]

#make a matrix to store the means in 
tidy_data_names <- list(1:total_rows, labeltemp)
tidy_data <- matrix(nrow=(length(subjects)*length(activities)), ncol=ncol(mean_std_table)-3, 
                    dimnames=tidy_data_names)

#make a vector to store corresponding subject number, activity name, and activity number
subject_number <- vector("integer", length=nrow(tidy_data))
activity_name <- vector("character", length=nrow(tidy_data))
activity_number <- vector("integer", length=nrow(tidy_data))

#for each subject
idxnum <- 1
for (s in subjects)
{
  for (a in activities) #for each activity for each subject
  {
    #pull out only that data
    tempmatrix <- mean_std_table[mean_std_table$subject_num == s & mean_std_table$activity_num == a,]
    
    #get the mean and std for that subject and activity
    tidy_data[idxnum,] <- sapply(tempmatrix[,2:80], mean)
    subject_number[idxnum] <- s
    activity_name[idxnum] <- activity_names[a]
    activity_number[idxnum] <- a
    #tidy_data[idxnum,1:3] <- tempmatrix[1,c(1, 81:82)]
    idxnum <- idxnum+1
  }
}

#make a data frame of the tidy data
tidy_data_table <- data.frame(tidy_data)

#add in columns that label the subject number, activity name, and activity number
tidy_data_table <- cbind(subject_number, activity_name, activity_number, tidy_data_table)
write.table(tidy_data_table, file="tidy_data_table.txt", row.name=FALSE)
