

features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
mean_index <- grep("mean\\(\\)", features[2])
sd_index<- grp("std\\(\\)", features[2])
mean_sd_indexes<- c(mean_index, sd_index)
names<- features[mean_sd_indexes,]

X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
sub<- X_train[mean_sd_indexes]


y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
train_set<- cbind(subject_train, y_train, sub)



X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
sub2<- X_test[mean_sd_indexes]
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
test_set<- cbind(subject_test, y_test, sub2)

data_merged<- rbind(train_set, test_set)


names<- names[, -1]
names<- gsub("t","", names)
names<- gsub("()","", names)
names(merged_set)<- c("Subject", "Activity", names)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
data_merged$Activity<- factor(data_merged$Activity,levels = activity_labels$V1, labels = activity_labels$V2)

library(dplyr)

average<- data_merged%>%
  group_by(Subject, Activity)%>%
  summarise_all(funs(mean))
