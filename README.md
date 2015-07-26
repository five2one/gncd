#Getting and Cleaning Data Course Project assignment

###This readme file describes how run_analysis.R script works.

1. Set a current working directory, ie setwd("D:/IntDownloads/coursa/gncd/passgn")

2. Obtain data from**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3. Manually unzip and put all relevant folders/files are inside "UCI HAR Dataset" folder.

4. Ensure the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.

5. Run source("run_analysis.R") command in RStudio to begin.

6. run_analysis.R script does the following within 5 steps:

* Merges the training and the test sets to create one data set.  
Stage output: Three set of raw joined dataset:-  
mergedata - combine training & test data,  
mergesubject -  combine training & test subject,  
mergelabel - combine training & test label

* Extracts only the measurements on the mean and standard deviation for each measurement.  
Stage steps: Remove unnecessary columns, insert col names, eliminate () in col names and convert names to all lowercase.

* Use descriptive activity names to name the activities in the data set.  
Stage steps: Convert activity description to all lowercase, use descriptive name instead of activity number, merge descriptive name to mergelabel dataset and insert new column names.

* Appropriately labels the data set with descriptive variable names.  
Stage steps: insert new column names for mergesubject dataset, joined the three tables. The unified (cleandta or mergedcleandta.txt) dataset is ready for any further manipulation.

* From the dataset in previous step, creates a second, independent tidy data set with the average of each variable for each activity.  
Stage steps: group dataset by its subject and activity then find the the group averages. Finally save the resulting (result or tidy_dataset.txt) dataset.


Two output files are generated in the current working directory:

* mergedcleandta.txt (8150kb): it contains a data frame called cleandta with dimension of 10299 x 68.

* tidy_dataset.txt (218Kb): it contains a data frame called result with dimension of 180 x 68.  



**Note: Dataset source:  
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
