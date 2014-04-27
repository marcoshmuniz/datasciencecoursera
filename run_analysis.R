run <- function()
{
if(!file.exists("./data")){
  dir.create("./data")
  print("data dir created")
}else{
  print("data dir already exists")
}
if(!file.exists("./data/ds.zip")){
  fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  print("downloading dataset...")
  download.file(fileUrl1,destfile="./data/ds.zip",method="curl")
  print("extracting dataset...")
  unzip("./data/ds.zip", list=FALSE)
}else{
  print("dataset already downloaded!")
  if(file.exists("./UCI HAR Dataset")){
    print("Dataset already extracted")
  }else{
    print("extracting dataset...")
    unzip("./data/ds.zip", list=FALSE)
  }
}
train_data_x <- read.table("UCI HAR Dataset/train/x_train.txt")
test_data_x <- read.table("UCI HAR Dataset/test/x_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_data_y <- read.table("UCI HAR Dataset/train/y_train.txt")
test_data_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
input_data <- rbind(train_data_x,test_data_x)
result_data <- rbind(train_data_y,test_data_y)
subject_data <- rbind(train_subject,test_subject)
names(subject_data) <- "subject"
names(result_data) <- "result"
merged_data <- cbind(input_data, subject_data,result_data)
print("data merged...")
#Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("UCI HAR Dataset/features.txt")
to_match <- c(".*mean\\(\\)", ".*std\\(\\)")
matches <- unique (grep(paste(to_match,collapse="|"), 
                        features$V2, value=TRUE))
columns <- features$V2 %in% matches
subset_data <- subset(merged_data, select=columns)
print("mean and std variables filtered...")
#Uses descriptive activity names to name the activities in the data set
names(subset_data) <- c(paste(features$V2[columns]), "subject","result")
print("descriptive names add to variables names...")
#Appropriately labels the data set with descriptive activity names. 
result_column <- subset_data$result
result_column<-as.data.frame(result_column)
names(result_column) <- "result"
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
column_labeled <- merge(result_column, activity_labels, by.x="result", by.y="V1")
subset_data$result <- column_labeled$V2
print("descriptive names added to activities...")
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)
melted_data <- melt(subset_data, id.vars=c("result","subject"))
tidy_data <- acast(melted_data, result+subject~variable,mean)
print("tidy data created!")
write.table(tidy_data, file="tidy_data.dat")
tidy_data
}