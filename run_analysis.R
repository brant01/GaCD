# You should create one R script called run_analysis.R that does the following. 
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement. 
#    Uses descriptive activity names to name the activities in the data set
#    Appropriately labels the data set with descriptive variable names. 
#    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Required Libraries
library('reshape2')
library('plyr')

# Reading in all data first, data frame names kept the same as file names

features <- read.table('UCI HAR Dataset/features.txt')
activity.labels <- read.table('UCI HAR Dataset/activity_labels.txt')
subject.test <- read.table('UCI HAR Dataset/test/subject_test.txt')
subject.train <- read.table('UCI HAR Dataset/train/subject_train.txt')
X.test <- read.table('UCI HAR Dataset/test/X_test.txt')
y.test <- read.table('UCI HAR Dataset/test/y_test.txt')
X.train <- read.table('UCI HAR Dataset/train/X_train.txt')
y.train <- read.table('UCI HAR Dataset/train/y_train.txt')


#combine X.test and X.train row-wise to create one dataframe with data from both 

X.all <- rbind(X.test, X.train)
y.all <- rbind(y.test, y.train)
subject.all <- rbind(subject.test, subject.train)

#Labeling headers to make the columns more clear

names(X.all) <- features[,2]
names(y.all) <- "Activity"
names(subject.all) <- "Subject"


#Creates master dataset with all data from the test and training datasets with Activity and Subject data

data <- cbind(y.all, X.all)
data <- cbind(subject.all, data)

#Selects only mean and std data

data.mean.sd <- data[ , c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,85,86,87,88)]

# Renames headers to be more descriptive

head <- c('Subject', 'Activity', 
          'Mean Body Accel X', 'Mean Body Accel Y', 'Mean Body Accel Z', 
          'STD Body Accel X', 'STD Body Accel Y', 'STD Body Accel Z', 
          'Mean Grav Accel X', 'Mean Grav Accel Y', 'Mean Grav Accel Z',
          'STD Grav Accel X', 'STD Grav Accel Y', 'STD Grav Accel Z',
          'Mean Body Accel Jerk X', 'Mean Body Accel Jerk Y', 'Mean Body Accel Jerk Z',
          'STD Body Accel Jerk X', 'STD Body Accel Jerk Y', 'STD Body Accel Jerk Z')
names(data.mean.sd) <- head



#Activity labels
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

#Assigns descriptions to activites


test <- data.mean.sd$Activity
test <- factor(test, labels = c('Walking', 'Walking Upstairs', 'Walking Downstairs', 'Sitting', 'Standing', 'Laying'))
data.mean.sd$Activity <- test

#Creates a second dataset with the average of each variable for each activty and each subject

data.melt <- melt(data.mean.sd, id = c('Subject','Activity'), measure.vars= c('Mean Body Accel X', 'Mean Body Accel Y', 'Mean Body Accel Z', 
                                                                              'STD Body Accel X', 'STD Body Accel Y', 'STD Body Accel Z', 
                                                                              'Mean Grav Accel X', 'Mean Grav Accel Y', 'Mean Grav Accel Z',
                                                                              'STD Grav Accel X', 'STD Grav Accel Y', 'STD Grav Accel Z',
                                                                              'Mean Body Accel Jerk X', 'Mean Body Accel Jerk Y', 'Mean Body Accel Jerk Z',
                                                                              'STD Body Accel Jerk X', 'STD Body Accel Jerk Y', 'STD Body Accel Jerk Z'))

data.final <- dcast(data.melt,  Subject + Activity ~ variable, mean)

# Output final data into a .txt file

write.table(data.final, file = 'tidy_data.txt', row.names = FALSE)     #as .txt file set row name to FALSE