GaCD
====

The file run_analysis.R is a text file that contains R script for obtaining the dataset submitted for grading.  It was created using R 3.1.1 via R Studio 0.98.953.

The data for this analysis was obtained via the 'Getting and Cleaning Data' course from Coursera from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The zip file was saved on, and unzipped on a MacBook Air running Mac OSX 10.9.4 on 8/24/14. The root downloaded file was saved as UCI HAR Dataset, and the R scrpit will work with this file saved in the working directory.

Code Book:

#Dataframes used in the script for initial loading were named in accordance to their file names, and are read in using read.table:

  ##features: data frame created from the file UCI HAR Dataset/features.txt
  ##activity.labels data frame created from the file UCI HAR Dataset/activity_labels.txt
  ##subject.test data frame created from the file UCI HAR Dataset/test/subject_test.txt
  ##subject.train data frame created from the file UCI HAR Dataset/train/subject_train.txt
  ##X.test data frame created from the file UCI HAR Dataset/test/X_test.txt
  ##y.test data frame created from the file UCI HAR Dataset/test/y_test.txt
  ##X.train data frame created from the file UCI HAR Dataset/train/X_train.txt
  ##y.train data frame created from the file UCI HAR Dataset/train/y_train.txt
  
  
A master dataframe was created by combining the dataframes that were loaded as above. 

First, the .test and .train dataframes were combined. The dataframe X.all was created by adding the rows of X.train to X. all.  The dataframe y.all was similarly created by adding the rows of y.train to y.test.  The dataframe subject.all was similarly created by adding the rows subject.train to subject.test. These steps combined all of the measurements for the .test and the .trial files in the oringinal data since for this analysis we will be treating them equally.

Next, the three .all dataframes were combined column-wise to create a master dataframe labled 'data'.

The rows of interest from the master datafram 'data' were the 'Subject', 'Activity', and those representing the means and standard deviations of the measured variables.  The dataframe data.mean.sd is a dataframe that is a subset of the master dataframe 'data' that includes only these columns.  It includes all rows that were in the original dataframe.

Headers for this dataframe were renamed as below:
  ##'Subject' - (Integer) from 'Subject': The number of the subject performing the test 
  ##'Activity' - (Factor) from 'Activity': The number of the activity being performed (described below) 
  ##'Mean Body Accel X' -(Numeric) from tBodyAcc-mean()-X
  ##'Mean Body Accel Y' - (Numeric) from tBodyAcc-mean()-Y
  ##'Mean Body Accel Z' - (Numeric) from tBodyAcc-mean()-Z
  ##'STD Body Accel X' - (Numeric) from tBodyAcc-std()-X
  ##'STD Body Accel Y' - (Numeric) from tBodyAcc-std()-Y
  ##'STD Body Accel Z' - (Numeric) from tBodyAcc-std()-Z 
  ##'Mean Grav Accel X' - (Numeric) from tGravityAcc-mean()-X
  ##'Mean Grav Accel Y' - (Numeric) from tGravityAcc-mean()-Y
  ##'Mean Grav Accel Z' - (Numeric) from tGravityAcc-mean()-Z
  ##'STD Grav Accel X' - (Numeric) from tGravityAcc-std()-X
  ##'STD Grav Accel Y' - (Numeric) from tGravityAcc-std()-Y
  ##'STD Grav Accel Z' - (Numeric) from tGravityAcc-std()-Z
  ##'Mean Body Accel Jerk X' - (Numeric) from tBodyAccJerk-mean()-X
  ##'Mean Body Accel Jerk Y' - (Numeric) from tBodyAccJerk-mean()-Y
  ##'Mean Body Accel Jerk Z' - (Numeric) from tBodyAccJerk-mean()-Z
  ##'STD Body Accel Jerk X' - (Numeric) from tBodyAccJerk-std()-X
  ##'STD Body Accel Jerk Y' - (Numeric) from tBodyAccJerk-std()-Y
  ##'STD Body Accel Jerk Z' - (Numeric) from tBodyAccJerk-std()-Z

The Activity column of the dataframe was changed to be a factor so each number would represent the activity for which it was recored:

  ##1 Walking
  ##2 Walking Upstairs
  ##3 Walking Downstairs
  ##4 Sitting
  ##5 Standing
  ##6 Laying
  
  
The data.melt dataframe was created by transforming the data.mean.sd dataframe into two 'id' variables (Activity, Subject) and the remaining measured variables.  The library 'reshape2' was called at the beginning of the script to perform this action.

The dataframe data.final represnts a final tidy dataframe that has calculated the average of each measured variable for every combination of the 'id' variables. The script outputs this as a text file called 'tidy_data.txt'.
