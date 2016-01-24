setwd("D:\\Cousera\\Coursera_DS\\Cleaning_data\\Week_4\\UCIHARDataset")

 

install.packages("dplyr")
library(dplyr)
files<-list.files(getwd(), recursive=TRUE)
files

Act_Test  <- read.table(file.path(getwd(), "test" , "Y_test.txt" ),header = FALSE)

head(Act_Test)

Act_Train <- read.table(file.path(getwd(), "train", "Y_train.txt"),header = FALSE)

head(Act_Train)

Sub_Train <- read.table(file.path(getwd(), "train", "subject_train.txt"),header = FALSE)
head(Sub_Train)

Sub_Test  <- read.table(file.path(getwd(), "test" , "subject_test.txt"),header = FALSE)
head(Sub_Test)

Fut_Test  <- read.table(file.path(getwd(), "test" , "X_test.txt" ),header = FALSE)
head(Fut_Test)

Fut_Train <- read.table(file.path(getwd(), "train", "X_train.txt"),header = FALSE)


Subject <- rbind(Sub_Train, Sub_Test)
Activity <- rbind(Act_Train, Act_Test)

Features <- rbind(Fut_Train, Fut_Test)

names(Subject)<-c("subject")
names(Activity)<- c("activity")

Fut_Names <- read.table(("features.txt"),head=FALSE)
head(Fut_Names)
names(Features)<- Fut_Names[,2]
head(Features)

Sub_Act <- cbind(Subject, Activity)
AllData <- cbind(Features, Sub_Act)
head(AllData,2)
subset_FeaturesNames<-Fut_Names[,2][grep("mean\\(\\)|std\\(\\)", Fut_Names[,2])]

head(subset_FeaturesNames)

selectedNames<-c(as.character(subset_FeaturesNames), "subject", "activity" )
class(selectedNames)
head(selectedNames)

Extract <- AllData[, selectedNames]

Act <- read.table("activity_labels.txt")
head(Act)
Activity_Sub <- Act[,1]
Activity_Sub
Activity_Sub1 <- Act[Activity_Sub, 2]
Activity_Sub1
head(Activity_Sub1)


# Appropriately labels the data set with descriptive variable names
names(AllData)<-gsub("^t", "time", names(AllData))
names(AllData)<-gsub("^f", "frequency", names(AllData))
names(AllData)<-gsub("Acc", "Accelerometer", names(AllData))
names(AllData)<-gsub("Gyro", "Gyroscope", names(AllData))
names(AllData)<-gsub("Mag", "Magnitude", names(AllData))
names(AllData)<-gsub("BodyBody", "Body", names(AllData))
names(AllData)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
AllData_final<-aggregate(. ~subject + activity, AllData, mean)
write.table(AllData_final, file = "AllData_final.txt",row.name=FALSE)
