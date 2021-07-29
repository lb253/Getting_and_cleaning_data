### REadME

#instruction for the assignement
 

   " Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
    
#What you need to run the script:
-package dplyr installed
- a file with the data called "UCI HAR Dataset"

#What the script run_analysis do :
  - load the data
  - create an index to select the features about mean and standart deviation
  - select the data from the train dataset with the index, insert subject and activity labels variables in the dataframe
  - select the data from the test dataset with the index,insert subject and activity labels variables in the dataframe
  -merge the two dataset
  -rename correctly the variables names. 
  
  -create the second data set: thanks to the library dplyr, we averaged each variable for each activity and each subject.

