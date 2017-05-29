library(dplyr)
library(reshape2)
#
datalabels <- read.table("./features.txt")
#
testdata <- read.table("./test/X_test.txt",header = F)
names(testdata) <- datalabels[,2]
testsubjects <- read.table("./test/subject_test.txt", col.names = c("subject"))
testlabels <- read.table("./test/y_test.txt", col.names = c("activity"))
test_ <- cbind(testdata,cbind(testlabels,testsubjects)) 
#
traindata <- read.table("./train/X_train.txt",header = F)
names(traindata) <- datalabels[,2]
trainsubjects <- read.table("./train/subject_train.txt", col.names = c("subject"))
trainlabels <- read.table("./train/y_train.txt", col.names = c("activity"))
train_ <- cbind(traindata,cbind(trainlabels,trainsubjects))
#
merged <- rbind(train_,test_)
#
# Convert activity and subjects to factors
merged$activity <- factor(merged$activity, 
                          labels = c("WALKING","WALKING_UPSTAIRS",
                                     "WALKING_DOWNSTAIRS","SITTING","STANDING",
                                     "LAYING"))
merged$subject <- as.factor(merged$subject)
#
# Select all columns with "mean" or "std" in the label.  Keep the activity (562)
# and subject (563) columns
means_stds <- merged[,c(grep(".*mean.*|.*std.*",names(merged)),562,563)]
#
# Melt dataframe into tall, skinny datframe
means_stds.melted <- melt(means_stds, id = c("subject", "activity"))
#
# Recast tall, skinny dataframe into tidy dataframe with data summarized into 
# means
means_stds.mean <- dcast(means_stds.melted, subject + activity ~ variable, mean)
#
# Data labels name cleanup
names(means_stds.mean) <- gsub('-mean', 'Mean', names(means_stds.mean))
names(means_stds.mean) <- gsub('-std', 'Std', names(means_stds.mean))
names(means_stds.mean) <- gsub('[-()]', '', names(means_stds.mean))
#
# Create the "tidy.txt" dataframe file
write.table(means_stds.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
