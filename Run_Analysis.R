# Run_Analysis.R
# Detailed explanation of the code can be found in CodeBook.md in this repo.

# Step 1)  Merges the training and the test sets to create one data set.
    # Read in the train/ and test/ subdata
    x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

    x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

    # Merge
    x_data <- rbind(x_train, x_test)
    y_data <- rbind(y_train, y_test)
    subject_data <- rbind(subject_train, subject_test)
    
# Step 2)  Extracts only the measurements on the mean and standard deviation for each measurement. 
    features <- read.table("./UCI HAR Dataset/features.txt")
    features_select <- grep("(mean|std)\\(\\)", features$V2)
    
    x_data_select <- x_data[, features_select]
    names(x_data_select) <- features[features_select, 2]
    
# Step 3)  Uses descriptive activity names to name the activities in the data set
    activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
    names(y_data) <- "activity"
    y_data$activity <- activities[y_data$activity, 2] 

# Step 4)  Appropriately labels the data set with descriptive variable names.
    names(subject_data) = "subject"
    
    data <- cbind(subject_data, y_data, x_data_select)
    
# Step 5)  From the data set in step 4, creates a second, independent tidy data 
#          set with the average of each variable for each activity and each subject.
    data$subject = as.factor(data$subject)
    data$activity = as.factor(data$activity)
    tidy_data <- aggregate(.~subject + activity, data, mean)
    
    write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
    
