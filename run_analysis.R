#url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(url,destfile="Dataset.zip") ##unzip dataset

###1.Merges the training and the test sets to create one data set.
test<-read.table("./test/X_test.txt")
train<-read.table("./train/X_train.txt")
total<-rbind(test,train)

###2.Extracts only the measurements on the mean and standard deviation for each measurement. 
Names<-read.table("./features.txt")[,2]
MeanStdCol<-grepl("mean|std", Names)
MeanStd<-total[,MeanStdCol]

###3.Uses descriptive activity names to name the activities in the data set
testLabels<-read.table("./test/Y_test.txt")
trainLabels<-read.table("./train/Y_train.txt")
totalLabels<-rbind(testLabels,trainLabels)
LabelName<-function(x){
  if(x==1){"walking"}
  else if(x==2){"walkingUp"}
  else if(x==3){"walkindDown"}
  else if(x==4){"sitting"}
  else{"laying"}
}
library(dplyr)
MeanStd<-mutate(MeanStd,Label=sapply(totalLabels[,1],LabelName))

###4.Appropriately labels the data set with descriptive variable names. 
variableName<-c(as.character(Names[MeanStdCol]),"label")
fixedName<-function(Names){
  Names<-sub("^t", "time", Names)
  Names<-sub("^f", "frequency", Names)
  Names<-sub("-m", "M", Names)
  Names<-sub("-s", "S", Names)
  Names<-sub("\\(\\)", "", Names)
  Names
}
variableName<-fixedName(variableName)
names(MeanStd)<-variableName

###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
testSubject<-read.table("./test/subject_test.txt")
trainSubject<-read.table("./train/subject_train.txt")
totalSubject<-rbind(testSubject,trainSubject)
MeanStd5<-cbind(MeanStd,"subject"=totalSubject[,])
library(tidyr)
MeanStd5<-gather(MeanStd5,labels,count,-label,-subject)
byActivitySubject<-group_by(MeanStd5,label,subject,labels)
Average<-summarize(byActivitySubject,mean(count))
write.table(Average,file="results.txt",row.name=FALSE) 