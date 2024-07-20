setwd("~/Desktop/FinalProj")

list.files("~/Desktop/FinalProj") 

#Set x variables for xtest and xtrain
xtest <- read.table("~/Desktop/FinalProj/test/X_test.txt", col.names = features$functions)
xtrain <- read.table("~/Desktop/FinalProj/train/X_train.txt", col.names = features$functions)

#Set y variables for ytest and ytrain
ytest <- read.table("~/Desktop/FinalProj/test/y_test.txt", col.names = "code")
ytrain <- read.table("~/Desktop/FinalProj/train/y_train.txt", col.names = "code")

#Set subject test and train variables
subjecttest <- read.table("~/Desktop/FinalProj/test/subject_test.txt", col.names = "subject")
subjecttrain <- read.table("~/Desktop/FinalProj/train/subject_train.txt", col.names = "subject")

#Set feartures and activites variables

features <- read.table("~/Desktop/FinalProj/features.txt", col.names = c("n","functions"))
activities <- read.table("~/Desktop/FinalProj/activity_labels.txt", col.names = c("code", "activity"))

#Now merging the training and testing into one dataset
x_test_train <- rbind(xtrain, xtest)
y_test_train <- rbind(ytrain, ytest)
subject_test_train <- rbind(subjecttrain, subjecttest)
newdataset <- cbind(x_test_train, y_test_train,subject_test_train )

TidyData <- newdataset %>% select(subject, code, contains("mean"), contains("std"))

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#Subject and Activity mean
FinalTidyData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

TidyData
FinalTidyData
