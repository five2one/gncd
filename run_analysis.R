#run_analysis.R
setwd("D:/IntDownloads/coursa/gncd/passgn")
rm(list=ls())
#
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1, destfile = "./20Dataset.zip")
#
# 1. Merges the training and the test sets to create one data set.
tmp1 <- read.table("./UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("./UCI HAR Dataset/test/X_test.txt")
mergedata <- rbind(tmp1, tmp2)  #combine training & test data
tmp3 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
tmp4 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
mergesubject <- rbind(tmp3, tmp4)  #combine training & test subject 
tmp5 <- read.table("./UCI HAR Dataset/train/y_train.txt")
tmp6 <- read.table("./UCI HAR Dataset/test/y_test.txt")
mergelabel <- rbind(tmp5, tmp6)  #combine training & test label
dim(mergedata)
#
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")   #read data features
meanStdIndices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])  #get col with mean & std
mergedata <- mergedata[, meanStdIndices]             #remove unnecessary columns
names(mergedata) <- features[meanStdIndices, 2]      #insert col names
names(mergedata) <- gsub("\\(|\\)", "", names(mergedata))   #eliminate () in col names
names(mergedata) <- tolower(names(mergedata))       #convert names to all lowercase
#
#3. Use descriptive activity names to name the activities in the data set (6 activity)
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))   #convert activity to all lowercase
activityLabel <- activity[mergelabel[, 1], 2]
mergelabel[, 1] <- activityLabel    #use descrective name instead of activity number
names(mergelabel) <- "activity"      #insert new column names
#
#4. Appropriately labels the data set with descriptive activity names.
names(mergesubject) <- "subject"
cleandta <- cbind(mergesubject, mergelabel, mergedata)  #column bind tables
write.table(cleandta, "mergedcleandta.txt")
#
#5. Creates a second, independent tidy data set with the average of each variable for each
#   activity and each subject.
subjectlength <- length(unique(mergesubject)[ ,1]) # 30 unique subjects
activitylength <- dim(activity)[1] # 6 activities
columnlength <- dim(cleandta)[2]   # 68 columns
result <- cleandta[1:(subjectlength*activitylength), ]
#
row <- 1        #tidy data by subject, activity and get its average
for(s in 1:subjectlength) {
    for(a in 1:activitylength) {
        result[row, 1] <- sort(unique(mergesubject)[ , 1])[s]
        result[row, 2] <- activity[a, 2]
        tmp <- cleandta[cleandta$subject==s & cleandta$activity==activity[a, 2], ]
        result[row, 3:columnlength] <- colMeans(tmp[, 3:columnlength])
        row = row+1
    }
}
write.table(result, "tidy_dataset.txt", row.name=FALSE)
