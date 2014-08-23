#You should create one R script called run_analysis.R that does the following. 
#0. read in the data files, from the folder UCI HAR Dataset and its subfolders train and test; 
#this folder is located in the working directory.

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")

#1.Merges the training and the test sets to create one data set.
#this associates only the measurement columns with each other: 
#assemble all measurements for all activities and all subjects, whether in the training 
#or test sets
all_measure<-rbind(X_test,X_train)
#this creates columns of activities and subjects to be column-bound later
all_sub<-rbind(subject_test,subject_train)
colnames(all_sub)<-"subject"
all_y<-rbind(y_test,y_train)
colnames(all_y)<-"activity"
#add a column with names to the activity frame; explicitly keep the number as well as the name
all_y$activitynames <- factor(all_y$activity, levels=activity_labels$V1, labels=activity_labels$V2)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#The instruction is confusingly worded. How I'm interpreting it: 
#keep the measurements that are means or standard deviation on any of the dimensions like tbodyACC
#To do this, first clean up the names in the features table
#change values to lower case
features$V2<-tolower(features$V2)
#remove punctuation
features$V2<-gsub("[[:punct:]]","",features$V2)
#add as column names to the measurements
colnames(all_measure)<-features$V2

#then create a vector of the features to keep and use this to subset the data: 
#use the grepl function to create a logical vector: T when the colname contains mean 
#or std and F otherwise; then subset on the columns where the value is T
matches<-c("mean","std")
sub_measure<-all_measure[,grepl(paste(matches,collapse="|"),colnames(all_measure))]

#then add in the columns for activities and subjects
final<-cbind(all_sub,all_y,sub_measure)

#3.Uses descriptive activity names to name the activities in the data set
#i.e. convert the y column into a factor and use the (provided) activity labels to replace 
#the numeric values with descriptive values. Keep the mis-spelling "laying" instead of "lying"
#this was done in line 23 above

#4.Appropriately labels the data set with descriptive variable names. 
#this was done in lines 30-34 above
#the conventions for varnames in the lecture notes were used: 
#all lower case, and no special characters.

#5.Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
#first calculate means by subject and activity
meanf<-aggregate(final[4:89],list(final$subject, final$activitynames), mean)
#then calculate sd by subject and activity
sdf<-aggregate(final[4:89],list(final$subject, final$activitynames), sd)
#then rename columns: each existing column gets either mean or sd prepended
colnames(meanf)<-paste("mean",colnames(sdf),sep="")
colnames(sdf)<-paste("sd",colnames(sdf),sep="")
#discard the first couple of columns of sdf: redundant
sdf<-sdf[3:88]
#make sensible names for the first couple of columns of meanf
colnames(meanf)[1]<-"subject"
colnames(meanf)[2]<-"activity"
#combine into a single data frame
final2<-cbind(meanf,sdf)
#write the output table
write.table(final2,file="gd6project.txt",row.name=FALSE)




