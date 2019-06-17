#read activity lables
act_label <- read.table("activity_labels.txt")

#read features
features <- read.table("features.txt")

#read test data
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#bind test data into one data frame test_data
test_data <- X_test
names(test_data) <- features[,2]

test_data <- cbind(subject_test, test_data)
names(test_data)[1] <- "Subject"

#Uses descriptive activity names to name the activities in the data set
Y_test <- cbind(Y_test, 1:nrow(Y_test))
Y_test <- merge(Y_test, act_label, sort=FALSE)
Y_test <- Y_test[order(Y_test[,2]),]
test_data <- cbind(Y_test[,3], test_data)
names(test_data)[1] <- "Activity Label"

#read train data
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

#bind train data into one data frame train_data
train_data <- X_train
names(train_data) <- features[,2]

train_data <- cbind(subject_train, train_data)
names(train_data)[1] <- "Subject"

#Uses descriptive activity names to name the activities in the data set
Y_train <- cbind(Y_train, 1:nrow(Y_train))
Y_train <- merge(Y_train, act_label, sort=FALSE)
Y_train <- Y_train[order(Y_train[,2]),]
train_data <- cbind(Y_train[,3], train_data)
names(train_data)[1] <- "Activity Label"

# Merges the training and the test sets to create one data set
w4_data <- rbind(test_data, train_data)

#Extracts only the measurements on the mean and standard deviation for each measurement
filter_col <- grep("mean\\(\\)", names(w4_data))
filter_col <- c(filter_col, grep("std\\(\\)", names(w4_data)))
filter_col <- c(1, 2, filter_col)
filter_col <- sort(filter_col)
w4_data_filter <- w4_data[,filter_col]

#Appropriately labels the data set with descriptive variable names
#Create a function to do translation of variable names

TranslateColumnName <- function(name)
{
  element <- strsplit(name, "-")[[1]]
  if (length(element) < 2) return(name)
  variable <- element[1]
  extended <- element[2]
  extended <- if (extended == 'mean()') "Mean over " else "StdDev over "
  
  if (length(element) == 3)  { 
    coordinate <- element[3]
    coordinate <- paste0(" on ", coordinate, "-axis")
    variable <- paste0(extended, variable, coordinate)
  } 
  else {
    variable <- paste0(extended, variable)
  }
  variable
}

NewName <- sapply(names(w4_data_filter), TranslateColumnName)
names(w4_data_filter) <- NewName

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

library(reshape2)
w4_melt <- melt(w4_data_filter, id = c("Activity Label", "Subject"))
w4_recast <- dcast(w4_melt, w4_melt$`Activity Label`+ w4_melt$Subject~variable, mean)
names(w4_recast)[1:2] <- c("Activity Label", "Subject")

write.table(w4_recast, file = "tidydataset.txt", row.names = FALSE)

