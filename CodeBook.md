Code Book for course project of "Getting and Cleaning Data" course
==================================================================

Data primary loaded into following datasets:
--------------------------------------------
- f_names - names of features
    - n - integer nidentifier
    - name - character name
- a_labels - activity labels
    - id - integer identifier
    - name - character name
- test_X - test features set
    - 561 column of features named like `f_names[, "name"]` (all float)
- train_X - train features set
    - 561 column of features named like `f_names[, "name"]` (all float)
- test_Y - test labels set
    - target - integer (from `a_labels[, "id"]`)
- train_Y - train labels set
    - target - integer (from `a_labels[, "id"]`)
- test_subj - subjects for test set
    - subject - integer
- train_subj - subjects for train set
    - subject - integer

Merges the training and the test sets to create one data set
------------------------------------------------------------
As far as I understand this requrements regards to features sets only - there
is no need in whole dataset (with subjects and labels) in computatinal after.
So I decided to merge features sets only on this stage.
resulting set X consists on train and test data

Extracts only the measurements on the mean and standard deviation for each measurement
--------------------------------------------------------------------------------------
My approach: if column name contains 'mean' or 'std' - than extruct it
if variable n consist on column names then `grep("mean", n)` gives indexes of 
columns with "mean" as substring.  
So `X[,c(grep("mean", n), grep("std", n))]` give us what we want.

Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------
- merge all label codes in one dataset: `Y <- rbind(train_Y, test_Y)`  
- create new column with full name: `Y <- merge(x=Y, y=a_labels, by.x="target", by.y="id", all.x=T, all.y=F)`
- add this column to X: `X$activity <- Y$name`

Appropriately labels the data set with descriptive variable names
-----------------------------------------------------------------
Couse we set col.names parameter during loading datasets - so we already have 
descriptive variable names

Creates a second, independent tidy data set with the average of each variable for each activity and each subject
---------------------------------------------------------------
`aggregate(X, by=list(activity=X$activity, subject=X$subject), FUN=mean)` does 
exectly what we need  
Dataset is tidy couse all colums contain one type of data and named appropriatly.  
All rows contain the same sets of data.  
Resulting set is stored in sitds.txt