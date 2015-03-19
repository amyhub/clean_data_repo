# CodeBook.md
Getting and Cleaning Data Course Project Repo
this is the codebook that describes the data clean up for the assignment

=========== ASSIGNMENT TEXT =====================================================================
background information:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

### information about the data set taken directly from 'README.txt' in the .zip file
======BEGIN QUOTED TEXT ==========================================================================================
======(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

======END QUOTED TEXT ==========================================================================================

### what is in "tidy_data_table.txt"

each row contains mean of sensor data for a given subject doing a given activity
1. column 1 is the subject number
2. column 2 is the activity name
3. column 3 is the activity number
4. columns 4:82 contain the means of the collected data

There were ~563 different features from the sensor data (as described above). These were seperated into test and training data sets. The test and training data sets were combined into one large table. The corresponding subject number was appended to each row. Then the corresponding activity name and number were appended to each row. Thus each row contained the subject number, the acitivy performed, and 563 data points collected by their phone. 

 This data was down-selected to include only data that had "mean" or "std" in the feature name. This left 79 features. Each subject performed 6 different activities many different times. For each subject, for each activity, the data for each feature was averaged. What remained was a tidy_data_table that had the means of 79 different features for each subject performing each activity. There were 30 subjects and 6 activities, thus, 180 total rows of tidy data. 



