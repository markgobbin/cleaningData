#If reshape2 does not load, type install.library("reshape2")
library(reshape2)

#Read in data headings
headings<-read.table("features.txt",header=FALSE,sep=" ")

#Read in data sets
trainX <- read.table("train/X_train.txt",header=FALSE,strip.white=TRUE)
testX <- read.table("test/X_test.txt",header=FALSE,strip.white=TRUE)

#Read in activity numbers corresponding to data
trainy <- read.table("train/y_train.txt",header=FALSE)
testy <- read.table("test/y_test.txt",header=FALSE)

#Read in labels signifying subject numbers

subtrain <- read.table("train/subject_train.txt",header=FALSE)
subtest <- read.table("test/subject_test.txt",header=FALSE)
#Apply column names to subject
colnames(subtrain) <- "Subject"
colnames(subtest) <- "Subject"

#Read in labels corresponding to activity numbers
ynums <- read.table("activity_labels.txt",header=FALSE)

#Apply labels to activity numbers.
# Because y_train.txt and y_test.txt includes numbers in column 1, we use the second column (name) only
trainynames <- data.frame(ynums[trainy[,1],2])
testynames <- data.frame(ynums[testy[,1],2])
#Apply column name to activity
colnames(trainynames) <- "Activity"
colnames(testynames) <- "Activity"

#apply column names to the data itself
colnames(trainX) <- as.vector(headings[,2])
colnames(testX) <- as.vector(headings[,2])

#extract mean and std columns
#### This is done now before we bind activity and subject columns, or they'll disappear 
#We could keep activity and subject columns through other means but I chose to extract now
trainX <- trainX[grepl("mean\\(\\)",names(trainX))|grepl("std\\(\\)",names(trainX))]
testX <- testX[grepl("mean\\(\\)",names(testX))|grepl("std\\(\\)",names(testX))]


#bind activity names to the tables
trainX <- cbind(trainynames,trainX)
testX <- cbind(testynames,testX)

#bind subjects to the tables
trainX <- cbind(subtrain,trainX)
testX <- cbind(subtest,testX)

#finally, bind rows together
result <- rbind(trainX,testX)

#### Now we have to take the mean by subject and activity ####
library(reshape2)
melt(result,id.vars=c("Subject","Activity"),variable.name="Feature") -> reshaped
dcast(reshaped,Subject+Activity~Feature,mean) -> reshaped

## Write out the result ##
write.table(reshaped,"meansBySubjectActivity.txt",row.names=FALSE)



