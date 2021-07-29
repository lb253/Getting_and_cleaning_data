download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI HAR Dataset")



#first we are going to create an index for selecting the correct data later one.
features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
mean_index <- grep("mean\\(\\)", features[2])
sd_index<- grp("std\\(\\)", features[2])
mean_sd_indexes<- c(mean_index, sd_index)

#we are going to use it later as the names for the variables
names<- features[mean_sd_indexes,]

#we are loading and selecting the data from the train set
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
sub<- X_train[mean_sd_indexes]

# we add the number subject and the activities label
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
train_set<- cbind(subject_train, y_train, sub)


#we do the same thing for the test set
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
sub2<- X_test[mean_sd_indexes]
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
test_set<- cbind(subject_test, y_test, sub2)

#we merge both sets. 
data_merged<- rbind(train_set, test_set)

#we names correctly the variables. ( we took away a "t" and parenthesis from the features names)
names<- names[, -1]
names<- gsub("t","", names)
names<- gsub("()","", names)
names(merged_set)<- c("Subject", "Activity", names)

# we transform the activities labels( previously number) in factor with complete names. 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
data_merged$Activity<- factor(data_merged$Activity,levels = activity_labels$V1, labels = activity_labels$V2)

# Now we can create the second dataset where we average each variable for each activity and each subject
library(dplyr)

tidy_data<- data_merged%>%
  group_by(Subject, Activity)%>%
  summarise_all(funs(mean))

#you can save it as a .txt if you like. 
write.table(tidy_data, "tidy_data.txt", row.names = F)
