Code Book
=================

This CookBook explains the data, the variables, and the work performed to clean up the dataset. 

## Data
The original zipped data is obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The file is downloaded, unzipped, and stored in my local computer. 

The first subdirectory includes 4 files (README.txt, features.txt, features_info.txt, and activity_labels.txt) and 2 subfolders (`train/` and `test/`). The `train/` and `test/` folder include 3 files (e.g., x_train.txt, y_train.txt, and subject_train.txt) and 1 folder (`Inertial Signals/`). README.txt describes the experiment and the content of each text file. Based on the project requirements, the `Inertial Signals/` folder is not used.   

## Code
As required by the project, the code run_analysis.R is taking the following steps:    
  
***Step 1)  Merges the training and the test sets to create one data set.***    
    The training and test datasets are stored in two separate folders `train/` and `test/`. The training data have 7352 records for 561 features (x_train.txt) with 6 activities (y_train.txt) of the 30 subjects (subject_train.txt). The test data have 2947 records for 561 features (x_test.txt) with 6 activities (y_test.txt) of the 30 subjects (subject_test.txt). This step reads out both the training data and test data using `read.table()` and merge them together using `rbind()`. The merged data are called `x_data`, `y_data`, and `subject_data`. They have 10299 rows, and 561, 1, and 1 columns individually.
          
***Step 2)  Extracts only the measurements on the mean and standard deviation for each measurement.***  
    Features names are stored at feature.txt and `grep()` can be used to selected the index of names with mean() and std(). Then the data with selected features `x_data_select` are extracted from `x_data` and the columns are given feature names extracted from feature.txt.
    
***Step 3)  Uses descriptive activity names to name the activities in the data set.***  
    Activity names can be read out from activity_labels.txt. Values in `y_data` (1~6) are replaced with activity names and this column in `y_data` is named by 'activity'.  

***Step 4)  Appropriately labels the data set with descriptive variable names.***  
    `subject_data` includes the subject number and thus given the name 'subject' using `names()` function. All the information are then put together into one table using `data <- cbind(subject_data, y_data, x_data_select)`. The data dataframe now includes 10299 rows and 68 columns. The 1st column is subject (1~30), the 2nd column is activity (6 types), and the next 66 columns are features with 'mean()' or 'std()'.
    
***Step5)  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.***   
    This step creates the tidy dataset by using `aggregate()` function. The features are aggregated over subject and activity using the mean function. This produces the final data frame `tidy_data` with 180 rows (30 subjects with 6 activities each, 30 x 6 = 180) and 68 columns. Each value in the 3~68 columns represent the average of each feature variable for each activity and each subject. For example, 
    
```{r}
tidy_data[1,1:3]
```
gives  

```{r}
  subject activity tBodyAcc-mean()-X
1       1   LAYING         0.2215982
```

This can be interpreted as: The tBodyAcc-mean()-X feature average for subject 1 in the LAYING activity is 0.2215982. 

Finally, the tidy data is write out using `write.table()` to "tidy_data.txt", which is also included in this repository. It is noted here that all the data in the original dataset have been normalized to -1 to 1 range, therefore, they are unitless. 




