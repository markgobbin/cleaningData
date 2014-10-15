#Read in data headings
headings<-read.table("features.txt",header=FALSE,sep=" ")

#Read in data sets
trainX <- read.table("train/X_train.txt",header=FALSE,strip.white=TRUE)
testX <- read.table("test/X_test.txt",header=FALSE,strip.white=TRUE)

#Read in activity numbers corresponding to data
trainy <- read.table("train/y_train.txt",header=FALSE)
testy <- read.table("test/y_test.txt",header=FALSE)

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

#bind activity names to the tables
train.act <- cbind(trainynames,trainX)
test.act <- cbind(testynames,testX)

#finally, bind rows together
result <- rbind(train.act,test.act)
