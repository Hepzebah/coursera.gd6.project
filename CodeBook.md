a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data

Data: 

The folder UCI HAR Dataset is in the working directory. The following files are read in from it:
*activity_labels.txt: for the indices 1-6, used in the data, this provides the corresponding text labels (Walking ...)
*features.txt: the first column contains the column number, and the second contains the text descriptions of the columns in the data
*train/X_train: data for the training set: measurements for each of the features
*train/subject_train: subject numbers for each of the rows in the X_train data
*train/y_train: activity numbers for each of the rows in the X_train data
*test/ contains analogous X, y, and subject files, for the test set

Variables:
*The relevant subset of the raw data is the data frame final: it contains subject number, activity name and number, and the subset of X (measurement) columns that are means or standard deviations. On the way there, the data frames all_measure, all_sub, all_y, and sub_measure were created. These are all combinations of various components of the input data.
*the data frames meanf and sdf contain the means and standard deviations calculated from the data in final. These are then bound to form the data frame final2, which is then written out as the final output.

Transformations:
*clean up the features: the text strings were converted to all lower case, and all non-alphanumeric characters were removed. The features were then used as column names for the X data.
*use the features/column names to filter out the irrelevant columns: the script uses the grepl function to create a logical vector: T when the colname contains mean #or std and F otherwise; then subset on the columns where the value is T; the result is a subset of the X data that contains only columns that are means or standard deviations of measured quantities.
*calculate means and standard deviations of all remaining data columns using the aggregate function
