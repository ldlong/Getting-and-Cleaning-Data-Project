## GETTING AND CLEARNING DATA PROJECT - run_analysis.R  SCRIPT

## You should create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names
## 5. Creates a second tidy data set with the average of each variable for each activity and each subject


# Set working directory and load required packages
setwd("~/R/Getting and Cleaning Data Project")
library(reshape2)


#load test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#load train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Load variable names
headers <- read.table("UCI HAR Dataset/features.txt")[,2]

# Load activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# Clean variable names
headers = gsub('-mean', 'Mean', headers)
headers = gsub('-std', 'Std', headers)
headers = gsub('[-()]', '', headers)

# Add variable names to test and train datasets
names(x_test) <- headers
names(x_train) <- headers

# Create filter for variables corresponding to the means and standard deviations
subset <- grepl("Mean|Std", headers)

# Apply the filter to the test and train datasets
x_test = x_test[,subset]
x_train = x_train[,subset]

# Merge the test and train datasets
x_comb <- rbind(x_test, x_train)
y_comb <- rbind(y_test, y_train)
subject_comb <- rbind(subject_test, subject_train)

# Create one dataset
combined <- cbind(subject_comb, y_comb, x_comb)
names(combined)[1] <- "Subject_ID"
names(combined)[2] <- "Activity"

# Calculate averages
data <- aggregate(. ~ Subject_ID + Activity, data= combined, FUN = mean)

# Apply activity labels
data$Activity <- factor(data$Activity, labels=activity_labels)

# Export table
write.table(data, file="tidydata.txt", row.names=FALSE)



