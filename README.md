---
Course: "Getting and Cleaning Data - Course Project"
Document: "Read Me"
---

## Background

This is the course project for the Getting and Cleaning Data Coursera course. The following files are included in the submission.

  1. ***README.md*** - includes the explanation of course project submission
  2. ***CodeBook.md*** - includes the codebook for the data
  3. ***run_analysis.R*** - includes R source code to fulfill the course project requirement
  4. ***tidydataset.txt*** - includes the tidy data as required by the course project

## How script works
  1. The script assumes the intial data of the course project already presents in R working directory
  2. The script reads activity label and feature
  3. The script reads test data and bind the data into one single data frame
  4. The script replace the activity label ID with the activity label in test data
  5. The script reads train data and bind the data into one single data frame
  6. The script replace the activity label ID with the activity label in train data 
  7. Combine test data and train data
  8. Remove all variables other than the ones contains "mean()" and "std()"
  9. Translate the variable description to human readable description
  10. Generate tidy dataset with average of each variable for each activity and each subject
