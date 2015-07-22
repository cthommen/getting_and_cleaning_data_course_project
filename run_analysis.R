######COURSERA-Getting and Cleaning Data Course Project
#Name: Christoph Thommen
#Date: 22.07.2015
#Data: Human Activity Recognition Using Smartphones Dataset

#Contents:
#- data import and putting data set together
#- minimize the number of variables in the data set
#- relabel the variables in the data set
#- creation of a second, independent tidy data set

#Tasks:
#1. Merge the training and the test set to create one data set.
#2. Extract only the measurements on the mean and standard deviation for each measurement. 
#3. Use descriptive activity names to name the activities in the data set.
#4. Appropriately label the data set with descriptive variable names. 
#5. From the data set in step 4, create a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

##########################################
#data import and putting data set together
##########################################

pathR="getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

#import of test data set (measurements, subjects and activities)
x_test=read.table(paste(pathR2,"test/X_test.txt",sep=""),sep="\t")
y_test=read.table(paste(pathR,"test/y_test.txt",sep=""),sep="\t")
subject_test=read.table(paste(pathR,"test/subject_test.txt",sep=""),sep="\t")

#import of training data set (measurements, subjects and activities)
x_train=read.table(paste(pathR,"train/X_train.txt",sep=""),sep="\t")
y_train=read.table(paste(pathR,"train/y_train.txt",sep=""),sep="\t")
subject_train=read.table(paste(pathR,"train/subject_train.txt",sep=""),sep="\t")

#import of features
features=read.table(paste(pathR,"features.txt",sep=""),sep="\t")
features=t(features)

#import of activity labels
activity_labels=read.table(paste(pathR,"activity_labels.txt",sep=""),sep="\t")
activity_labels$activity_nr=substr(activity_labels$V1,1,1)

#TASK 3: Use descriptive activity names to name the activities in the data set.
activity_labels$activity=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#merge activity numbers and activity labels
activity_test=merge(y_test,activity_labels[,2:3],by.x="V1",by.y="activity_nr")
activity_train=merge(y_train,activity_labels[,2:3],by.x="V1",by.y="activity_nr")

#put together subject, activity and measurement information
test_data=cbind(subject_test,activity_test,x_test)
train_data=cbind(subject_train,activity_train,x_train)

#rename test and training data sets
names=cbind("subject_nr","activity_nr","activity",features)
dimnames(test_data)[[2]]=names
dimnames(train_data)[[2]]=names

#TASK 1: Merge the training and the test set to create one data set.
data=rbind(test_data,train_data)

##########################################
#minimize the number of variables in the data set
##########################################

#TASK 2:Extract only the measurements on the mean and standard deviation for each measurement. 
features=unlist(features)
temp1=features[agrep("mean",features)]
temp2=features[agrep("std",features)]
mean_std_list=features[features %in% c(temp1,temp2)]
data_mean_std=cbind(data[,1:3],data[,mean_std_list])

##########################################
#relabel the variables in the data set
##########################################

#clean the variable names
mean_std_list=gsub("tB", "B", mean_std_list)
mean_std_list=gsub("tG", "G", mean_std_list)
mean_std_list=gsub("fB", "B", mean_std_list)
mean_std_list=gsub("Acc", "Accelerometer_", mean_std_list)
mean_std_list=gsub("Gyro", "Gyroscope_", mean_std_list)
mean_std_list=gsub("Mag", "Magnitude_", mean_std_list)
mean_std_list=gsub("Body", "Body_", mean_std_list)
mean_std_list=gsub("Gravity", "Gravity_", mean_std_list)
mean_std_list=gsub("Jerk", "Jerk_", mean_std_list)
mean_std_list=gsub("()-","",mean_std_list)

temp3=strsplit(mean_std_list, " ")
temp4=unlist(temp3)
variable_names=temp4[nchar(temp4)>4]

#TASK 4: Appropriately label the data set with descriptive variable names. 
dimnames(data_mean_std)[[2]]=c("subject_nr","activity_nr","activity",variable_names)

##########################################
#creation of a second, independent tidy data set
##########################################

#TASK 5:From the data set in step 4, create a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

data_mean_std$subject_activity=paste(data_mean_std$subject_nr,data_mean_std$activity,sep="")

aggregate_data=aggregate(data_mean_std[,c(1,2,4:89)],by=list(data_mean_std$subject_activity),mean)
final_data_temp=merge(aggregate_data,activity_labels[,2:3],by="activity_nr",all.x=T)
final_data=final_data_temp[,c(90,3:89)]
dimnames(final_data)[[2]]=c("activity","subject_nr",variable_names)

#export tidy data set
write.table(final_data,paste(pathR,"tidy_data_set.txt",sep=""),row.name=FALSE)


