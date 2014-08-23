coursera.gd6.project
====================
The one script used to run the analysis for this project in R (run_analysis.R) is in this repository. It is supposed to be saved to the working directory, and the UCI HAR Dataset folder is supposed to be in the working directory too. The script goes through the following steps:
0. read in the data files, from the folder UCI HAR Dataset and its subfolders train and test; save them as data frames within R
1.Merge the training and the test sets to create one data set. This is done only on the measurements (X) initially for convenience. Later the activities (y) and subjects are added.
2.Extract only the measurements on the mean and standard deviation for each measurement. (The instruction is confusingly worded. How I'm interpreting it: keep the measurements that are means or standard deviation on any of the dimensions like tbodyACC.) The script uses the grepl function to create a logical vector: T when the colname contains mean #or std and F otherwise; then subset on the columns where the value is T
3.Use descriptive activity names to name the activities in the data set
4.Appropriately label the data set with descriptive variable names. 
5.Create a second, independent tidy data set with the average of each variable for each activity and each subject. The script does this by using the aggregate function twice, to calculate first means and then standard deviations; the results are then column-bound into a table of results. The results are saved as a text file using write.table.
