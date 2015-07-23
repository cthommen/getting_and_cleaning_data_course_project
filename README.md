*README to run_analysis.r*

COURSERA-Getting and Cleaning Data Course Project
Name: Christoph Thommen
Date: 22.07.2015

The R-script run_analysis.r does import the data of the project "Human Activity Recognition Using Smartphones Dataset", edit them and create a second, independent tidy data set. In detail, the following contents are covered by the script:
- data import and putting data set together
- minimize the number of variables in the data set
- relabel the variables in the data set
- creation of a second, independent tidy data set

As part of these chapters the following tasks are executed by the script:
1. Merge the training and the test set to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the 
   average of each variable for each activity and each subject.

The following files are imported by the R-script, after they were saved manually as tab delimited txt-files:
- X_test.txt
- y_test.txt
- subject_test.txt
- X_train.txt
- y_train.txt
- subject_train.txt
- features.txt
- activity_labels.txt

The following files is exported by the R-script as tab delimited txt-files:
- tidy_data_set.txt