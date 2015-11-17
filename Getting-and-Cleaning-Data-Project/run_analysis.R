
setwd("C:/Users/dbaron1/Box Sync/Coursera/R")

if (!require("data.table")) {
  install.packages("data.table")}

require("data.table")


TestData <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/test/X_test.txt",header=FALSE)
TestDataAct <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/test/y_test.txt",header=FALSE)
TestDatasub <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

TrainData <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/train/X_train.txt",header=FALSE)
TrainDataact <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/train/y_train.txt",header=FALSE)
TrainDatasub <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# 3. name the activities in the dataset
activities <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
TestDataAct$V1 <- factor(TestDataAct$V1,levels=activities$V1,labels=activities$V2)
TrainDataact$V1 <- factor(TrainDataact$V1,levels=activities$V1,labels=activities$V2)

# 4. label the dataset with descriptive activity names
features <- read.table("C:/Users/dbaron1/Box Sync/Coursera/R/UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(TestData)<-features$V2
colnames(TrainData)<-features$V2
colnames(TestDataAct)<-c("Activity")
colnames(TrainDataact)<-c("Activity")
colnames(TestDatasub)<-c("Subject")
colnames(TrainDatasub)<-c("Subject")

# 1. merge test and training sets into one datasets
TestData<-cbind(TestData,TestDataAct)
TestData<-cbind(TestData,TestDatasub)
TrainData<-cbind(TrainData,TrainDataact)
TrainData<-cbind(TrainData,TrainDatasub)
bigData<-rbind(TestData,TrainData)

# 2. extract measurements on the mean and standard deviation for each measurement
bigDatamean<-sapply(bigData,mean,na.rm=TRUE)
bigDatasd<-sapply(bigData,sd,na.rm=TRUE)

# 5. Create independent tidy dataset with the average of each variable 
DT <- data.table(bigData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy.csv",sep=",",row.names = FALSE)

