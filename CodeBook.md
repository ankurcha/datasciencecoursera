# Tidy data set

1. Merge the training and the test sets to create one data set.  
This is done using the functions `cbind` (to merge x_test, y_test 
and subject_test for both train and test data sets) and the `rbind` 
to merge the two data sets together. The result data will have 10299 
rows and 561 columns.

2. Extracts only the measurements on the mean and standard deviation for each measurement.  
This is done by using the `grep` function extracting every variable containing "mean" 
OR "std". The result data frame will contain 10299 rows but only 81 columns (79 containing 
"mean" or "std" plus the "activity" and "subject" columns, needed later.  
It was not clear whether to cut off the "meanFreq()" variable. I have decided to leave it 
there in case it would be useful.

3. Uses descriptive activity names to name the activities in the data set  
It was easy to define the columns names with the function `colnames`.

4. Appropriately labels the data set with descriptive activity names.  
This step was achieved by using the ```gsub``` function. In particular the following transformation were included:  
`-mean` --> `Mean`
`-std` --> `StdDev`  
`()-` --> <REMOVE>
`BodyBody` --> `Body`

5. Created an independent tidy data set with the average of each variable for each activity and each subject.  
A combination of the `melt` and the `dcast` function permits to calculate the mean for every activity/subject couple. 
