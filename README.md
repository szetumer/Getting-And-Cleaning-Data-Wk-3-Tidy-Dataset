# Getting-And-Cleaning-Data-Wk-3-Tidy-Dataset

The following script generates datasets derived from data collected from the Human Activity Recognition Using Smartphones Dataset, provided by a collaboration between the Non-Linear Complex Systems Laboratory at SmartLab and the Technical Research Centre for Dependency Care and Autonomous Living at BarcelonaTech in Spain.

===================================================================================================
Experiment/Raw Data Description (as taken from the “README.txt” file in dataset provided from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

===================================================================================================

Original Data Description (Files used in dataset creation):

/UCI HAR Dataset

/features.txt - a list of all the variable names. This list is 561 rows long, indicating that for each instance of a person/activity combination, there are a batch of 561 variables describing that person doing that activity in that instance. This list was used to populate the column names in the resultant datasets.

/activity_labels.txt - a list of activities, and their corresponding numerical code. This list was used in conjuction with the y_test.txt and y_train.txt files to determine which activity was happening for each batch of 561 variables.
	
/test/y_test.txt - a list of the numeric activity codes for the participants in the test group. For each number listed here, there were 561 numbers in the X_test.txt file corresponding to the 561 variables associated with each instance of each subject doing each activity. The meaning of each activity number was assigned using the activity_labels.txt file.
	
/test/subject_test.txt - a list of the subjects who performed activites that were recorded in the test group. It lists the subject's ID for that row's batch of 561 variables in the X_test.txt file. For example, the third row indicates that the second subject (subject "2"), performed an activity, the label of which is found in the third row of the the y_test.txt file, that has the third batch 561 variables found in the X_test.txt file associated with that instance of activity performed by that subject.
	
/test/X_test.txt - a list of the variables associated with each instance of an activity and subject in the the test group. Each batch of 561 numbers is associated with an instance of an activity and a subject. For example, the first 561 numbers in this file are associated with activity "5" (which is on the first row of the y_test.txt file) and subject "2" (which is on the first row of subject_test.txt file).
	
/train/y_test.txt, /train/subject_train.txt, /train/X_train.txt - equivalent files for the training set of subjects.

===================================================================================================

Script description:

The script has essentially 9 parts:

1) download the aformentioned files.

2) combine the X_test and X_train, y_test and y_train, and subject_test and subject_train datasets into one X, y, and subject datasets. The X set (called "data") is the list of batches of 561 variables that correspond to each instance of an activity and subject in both the test and train groups. The y set (called "activities") is the list of activities that correspond to the activity number after combining y_test with y_train.

3) create a dataframe with each row corresponding to a batch of the 561 variables in the "data" variable. The columns of this dataframe were named according to the variable names, given by the features.txt file.

4) With each row in the dataframe, attach the subject name (given by the "subjects" list), and the activity name (given by the "activities" list) corresponding to that batch of variables.

Now, here the instructions are ambiguous. It says to "extracts only the measurements on the mean and standard deviation for each measurement," and then "from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." It is unclear whether the user wants a) a data set of every variable, activity, and subject, averaged over the instances of activity and subject-number pairs, or b) an average of only the variables that are the mean standard deviation of the direct measurements, averaged over the instances of activity and subject-number pairs. So both datasets have been provided. Steps 5 through 6 are to create a dataset that contains all variables, averaged over all instances of each subject,activity pair. Steps 7 through 9 create a dataset of only the variables that are means or standard deviations of measured quantities, averaged over all instances of each subject,activity pair.

5) Take the dataframe and melt it with the id variables as "subjects" and "activities", and the measurement variables as the 561 variables.

6) recast the dataframe, averaging over both id variables. This produces a dataframe where each variable in each instance of one subject/activity pair is averaged with every other instance of that variable. The resultant dataframe has 563 columns, one for each id variable (subject and activity) and one for each variable.

THIS CREATES A DATAFRAME OF ALL THE VARIABLES.

7) pair down the unmelted dataframe's columns to include only those that are entries for variables that are means or standard deviations (these are variables 1,2,3,4,5,6,41,42,43,44,45,46,121,122,123,124,125,126,126).

8) melt the dataframe as you did in step 5, but this time with fewer measurement variables.

9) recast the dataframe as you did in step 6, but this time with fewer columns created.

THIS CREATES A DATAFRAME OF ONLY THE VARIABLES THAT ARE MEANS OR STANDARD DEVIATIONS OF DIRECT MEASUREMENTS.

===================================================================================================

