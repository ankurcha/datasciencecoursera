# Getting and Cleaning Data

## Problem statement

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

# Project requirements

Create one R script called run_analysis.R that does the following: 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Solution description:

To run the script, copy to buffer and paste in console, or, download `run_analysis.R` to working directory and issue `source("./run_analysis.R")` from console to load and run the script.

* The script first checks the working directory for the dataset and downloads it if necessary. It then goes on to perform the needed transformations on the data. 


# Dependencies
The script depends on the following libraries: `dplyr`, `data.table` and `reshape2`. They are installed if not already available.

# Output
The tidy data (as required by step 5) is emitted to a file: `tidy_data.txt`.
