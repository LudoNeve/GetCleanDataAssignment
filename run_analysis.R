#Load required packages
library(dplyr)
library(plyr)
library(reshape2)

#Working directory should contain 2 folders: "train" and "test"
#Read required files and load them into R
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#Step 1: Merge the datasets and name the columns
test<- cbind(subject_test,y_test,x_test)
train<- cbind(subject_train,y_train,x_train)

features <- read.table("./features.txt")
features <-as.character(features[,2])
names <- c("subject","label",features)
data <-rbind(test,train)
names(data)<-names

#Step 2: Extract only the measurements on the mean and std
index_req<-grep("mean()",names,fixed=TRUE)
A <- data[,index_req]
index_req<-grep("std()",names,fixed=TRUE)
B <- data[,index_req]
C<-cbind(rbind(subject_test,subject_train),rbind(y_test,y_train),A,B)
C[,1]<-as.factor(C[,1])

#Step 3: Use the descriptions in activity_labels.txt to change contents 
#of column 2
for (i in 1:dim(C)[[1]]){
  if (C[i,2] ==1) {C[i,2]= "Walking"}
  if (C[i,2] ==2) {C[i,2]= "Walking_Upstairs"}
  if (C[i,2] ==3) {C[i,2]= "Walking_Downstairs"}
  if (C[i,2] ==4) {C[i,2]= "Sitting"}
  if (C[i,2] ==5) {C[i,2]= "Standing"}
  if (C[i,2] ==6) {C[i,2]= "Laying"}
  
}
C[,2]<-as.factor(C[,2])

#Step 4: Give the variables descriptive names
names(C) <- c("Subject","Activity",names(A),names(B))

#Step 5: Create new tidy dataset with only the averages 
#for each subject and each subject
melted <- melt(C, id.vars=c("Subject", "Activity"))
tidy <- ddply(melted, c("Subject","Activity"), summarise,
              mean = mean(value))
write.table(tidy,"tidy_data.txt",row.name=FALSE)