#first need to load the files
#assumes we are in the UCI HAR Dataset directory as per brief
trainDataX<-read.table("./train/X_train.txt")
subjectTrain<-read.table("./train/subject_train.txt")
trainDataY<-read.table("./train/Y_train.txt")

testDataX<-read.table("./test/X_test.txt")
subjectTest<-read.table("./test/subject_test.txt")
testDataY<-read.table("./test/Y_test.txt")

features<-read.table('features.txt')
actLabels<-read.table('activity_labels.txt')

#Merges the training and the test sets to create one data set.
mergedDataX<-rbind(trainDataX,testDataX)
mergedSubjects<-rbind(subjectTrain,subjectTest)
mergedDataY<-rbind(trainDataY,testDataY)

#features ended up with the second col having the var name and the feature name, first col is just a counter
#so must index twice to get to a vector of features
justFeatureNames<-features[[2]]

#Uses descriptive activity names to name the activities in the data set
names(mergedDataX)<-justFeatureNames
names(mergedDataY)<-c("ActId")
names(mergedSubjects)<-c("Subject")
#will want to join these to merged data by ActId
names(actLabels)<-c("ActId","ActName")

#Extracts only the measurements on the mean and standard deviation for each measurement.
relevantFeatureNames<-grep("mean|std",justFeatureNames)
relevantMergedData<-mergedDataX[,relevantFeatureNames]

#Appropriately labels the data set with descriptive variable names.
mergedFinalActs<-merge(actLabels,mergedDataY,"ActId")
relevantMergedData$Activity<-mergedFinalActs$ActName
relevantMergedData$Subject<-mergedSubjects$Subject

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#we know the final two cols are act and subject
finalColToAgg<-dim(relevantMergedData)[2]-2
step5Set<-aggregate(relevantMergedData[,1:finalColToAgg],list(act = relevantMergedData$Activity, subJ=relevantMergedData$Subject),mean, na.rm=TRUE)

#write.table(relevantMergedData,'relevant_clean_data.txt')
write.table(step5Set,"step5set.txt",row.name = FALSE)
