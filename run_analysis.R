#load all datasets
f_names <- read.csv("UCI HAR Dataset/features.txt", header=F, sep="", 
                   col.names=c("n", "name"), stringsAsFactors=F)
a_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", header=F, sep="", 
                   col.names=c("id", "name"), stringsAsFactors=F)
test_X <- read.csv("UCI HAR Dataset/test/X_test.txt", head=F, sep="", 
                  col.names=f_names[,"name"])
test_Y <- read.csv("UCI HAR Dataset/test/y_test.txt", head=F, 
                  col.names=c("target"))
test_subj <- read.csv("UCI HAR Dataset/test/subject_test.txt", head=F, 
                     col.names=c("subject"))
train_X <- read.csv("UCI HAR Dataset/train/X_train.txt", head=F, sep="", 
                  col.names=f_names[,"name"])
train_Y <- read.csv("UCI HAR Dataset/train/y_train.txt", head=F, 
                  col.names=c("target"))
train_subj <- read.csv("UCI HAR Dataset/train/subject_train.txt", head=F, 
                     col.names=c("subject"))

# "Merges the training and the test sets to create one data set"
# merge in natural order: train-test )
X <- rbind(train_X, test_X)

# "Extracts only the measurements on the mean and standard deviation for each measurement."
# my approach: if column name contains mean or std - than extruct it
n = names(X)
X_mean_std <- X[,c(grep("mean", n), grep("std", n))]

# "Uses descriptive activity names to name the activities in the data set"
Y <- rbind(train_Y, test_Y)
Y <- merge(x=Y, y=a_labels, by.x="target", by.y="id", all.x=T, all.y=F)
X$activity <- Y$name

# "Appropriately labels the data set with descriptive variable names."
# I guess that it is already done during loading stage

# "Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject"
X$subject <- rbind(train_subj, test_subj)$subject
sitds <- aggregate(X, by=list(activity=X$activity, subject=X$subject), FUN=mean)
write.table(x=sitds, file="sitds.txt")

