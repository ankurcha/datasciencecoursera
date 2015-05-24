#################################################
## @course: Getting and Cleaning Data          ##     
## @author: Ankur Chauhan <ankur@malloc64.com> ##
#################################################

# install and load libraries
if(!require("data.table")) { install.packages("data.table") }; require("data.table")
if(!require("reshape2")) { install.packages("reshape2") }; require("reshape2")
if(!require("dplyr")) { install.packages("dplyr") }; require("dplyr")

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- paste(getwd(), "/dataset.zip", sep = "")
dataLocation <- paste(getwd(), "/UCI HAR Dataset", sep = "")

# check if we have already downloaded and extracted the dataset
if (!file.exists(paste(dataLocation, "/README.txt", sep = ""))) {

  # download the file if needed
  if(!file.exists(destFile)) {
    res <- tryCatch(download.file(fileURL, destfile=destFile, method="curl", quiet = TRUE),
                    error=function(e) 1)
    # unzip file
    if (res != 1) {
      unzip(destFile)
    } else {
      print("Something went wrong!")
    }
  }
}

# read data
features <- read.table(paste(dataLocation, "/features.txt", sep =""))
colnames(features) <- c("feature", "featureName")
activity_labels <- read.table(paste(dataLocation, "/activity_labels.txt", sep =""))
colnames(activity_labels) <- c("activity", "activityName")

# load test data
test_subject <- read.table(paste(dataLocation, "/test/subject_test.txt", sep =""))
test_x <- read.table(paste(dataLocation, "/test/X_test.txt", sep =""))
test_y <- read.table(paste(dataLocation, "/test/Y_test.txt", sep =""))

# load training data
train_subject <- read.table(paste(dataLocation, "/train/subject_train.txt", sep =""))
train_x <- read.table(paste(dataLocation, "/train/X_train.txt", sep =""))
train_y <- read.table(paste(dataLocation, "/train/Y_train.txt", sep =""))

# assign nice column names to all datasets
colnames(test_subject) <- c("subject")
colnames(test_x) <- features$featureName
colnames(test_y) <- c("activity")

colnames(train_subject) <- c("subject")
colnames(train_x) <- features$featureName
colnames(train_y) <- c("activity")

# 1. Merge training and test data
test <- cbind(test_x, test_y, test_subject)
train <- cbind(train_x, train_y, train_subject)
data <- rbind(test, train)

# filtering the "mean" and "std" variables (plus subject and label) and exclude the others
data <- data[grep("mean|std|activity|subject", colnames(data))]

# do an outer-join(cleaned_data, activity_labels)
data <- merge(data, activity_labels, by="activity", all.x = TRUE)

# formatting columns with descriptive names
colnames(data) <- gsub('BodyBody', 'Body', 
                  gsub('[()-]', '', 
                  gsub('-std', 'StdDev', 
                  gsub('-mean', 'Mean', 
                  colnames(data)))))

# remove "activity" column since we do not 
finalData <- data[, colnames(data) != "activity"]

# generate the tidy data set
ids = c("subject", "activityName")
measures = setdiff(colnames(finalData),ids)
molten_data <- melt(data, id = ids, measure.vars = measures)
tidy_data <- dcast(molten_data, subject + activityName ~ variable, mean)

# write to file: tidy_data.txt
write.table(tidy_data, file = "./tidy_data.txt")
