originalwd <- getwd()
        
#First we need to extract the relevant files
#These first ones are the label files.
setwd("./UCI HAR Dataset")
        
#This is the codex of variable names, and will be used to complete OBJECTIVE 4:
#"Appropriately label the data set with descriptive variable names."
features_labels <- read.table("features.txt", header = FALSE, sep = " ", col.names = c("feature_numbers","feature_names"), colClasses = c("integer","character"))
        
#Use activity_labels to label the activities, thus accomplishing OBJECTIVE 3:
#"Uses descriptive activity names to name the activities in the data set"
activity_labels <- read.table("activity_labels.txt", header = FALSE, sep = " ", col.names = c("activity_numbers","activity_names"), colClasses = c("integer","character"))

setwd(originalwd)        
#These ones are the test files
setwd("./UCI HAR Dataset/test")
subject_test <- scan("subject_test.txt")
data_test <- scan("X_test.txt")
activity_test <- scan("y_test.txt")

setwd(originalwd)
#These ones are the train files
setwd("./UCI HAR Dataset/train")
subject_train <- scan("subject_train.txt")
data_train <- scan("X_train.txt")
activity_train <- scan("y_train.txt")
        
#Combinte the test and training files
#We replace the activity number with the activity name, too.
#THIS COMPLETES OBJECTIVE 1:
#"Merges the training and the test sets to create one data set."
subjects <- as.integer(c(subject_test, subject_train))
activities <- as.integer(c(activity_test, activity_train))
activities <- activity_labels$activity_names[activities]
data <- as.numeric(c(data_test, data_train))
        
#Then we put the data from the extraction into a dataframe
#first we start by creating an empty matrix.
df <- matrix(data[1:561], nrow = 1, ncol = 561)
colnames(df) <- features_labels$feature_names
df <- as.data.frame(df)
        
#go back to the original directory
setwd(originalwd)
        
#then we have to cycle through and put all the
#chunks of data in the right place.
        
marker <- ((length(data)/561)-1)
for (i in 1:marker){
        df <- rbind(df,data[(561*i+1):(561*i+561)])
}
        
#then we tack on the activity and the subject labels
#for each 561 length row of observations.
df <- cbind(activities,df)
df <- cbind(subjects,df)
#we double check that the colnames are correct.
#Should be a total of 563 columns.
colnames(df) <- c("subjects","activities", features_labels$feature_names)

#Then we have to melt the data
#with subj and activ. as id variables
#and features as measure variables
        
meltdf <- melt(df, id = c("subjects","activities"), measure.vars = as.character(features_labels$feature_names))

#then we cast it to take the average over each subject/activity pair.

largeavgdf <- dcast(meltdf, subjects + activities ~ variable, mean)

#and we write it to a file.
write.table(largeavgdf, file = "All_Vars_Dataset.txt", row.names = FALSE)