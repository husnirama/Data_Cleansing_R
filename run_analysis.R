library(data.table)

directory <- 'D:/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/'

#------------------------------------------------------------------------------#
# read activity labels & attributes name #
temp <- read.table(paste(directory,'activity_labels.txt',sep =""), sep = "")
ActLbl <- as.character(temp$V2)
temp <- read.table(paste(directory,'features.txt',sep =""), sep = "")
AttrNm <- temp$V2

# 4.Appropriately labels the data set with descriptive variable names.
library(stringr)
AttrNm <- gsub("[^[:alnum:]]", "", AttrNm)
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# read train & test data set #
Xtrain <- read.table(paste(directory,'train/X_train.txt',sep =""), sep = "")
colnames(Xtrain) <- AttrNm
Ytrain <- read.table(paste(directory,'train/y_train.txt',sep =""), sep = "")
names(Ytrain) <- "Act"

# read subject #
trainSubjects <- read.table(paste(directory,"train/subject_train.txt", sep = ""),sep="")
names(trainSubjects) <- "subject"
trainSubjects$subject <- as.factor(trainSubjects$subject)

# create train dataset #
train <- cbind(Xtrain, trainSubjects, Ytrain)
#------------------------------------------------------------------------------#

# read test data set #
Xtest <- read.table(paste(directory,'test/X_test.txt',sep =""), sep = "")
colnames(Xtest) <- AttrNm
Ytest <- read.table(paste(directory,'test/y_test.txt',sep =""), sep = "")
names(Ytest) <- "Act"

# read subject #
testSubjects <- read.table(paste(directory,"test/subject_test.txt", sep = ""),sep="")
names(testSubjects) <- "subject"
testSubjects$subject <- as.factor(testSubjects$subject)

# create test dataset #
test <- cbind(Xtest, testSubjects, Ytest)
#------------------------------------------------------------------------------#

# 1.merge train and test data set
data <- rbind(train,test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# read all colnames data
colnm <- colnames(data)
mean = grep("*mean*",colnm)
stdev = grep("*std*",colnm)
# append mean & stdev
all = append(mean,stdev)
#extract all the mean and std for each measurment
master <- data[,all]

# 3.Uses descriptive activity names to name the activities in the data set
master$subject <- data$subject
data$Act <- as.factor(data$Act)
levels(data$Act) <- ActLbl
master$act <- data$Act

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnm <- colnames(master)
groupnm <- colnm[1:(length(colnm)-2)]

library(dplyr)
DT <- master %>%
  group_by(subject, act) %>% 
  summarise_at(.vars= groupnm, funs(mean,sum))