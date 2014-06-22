library("plyr")

loadFeatures <- function(){
  # Loading features
  features <- read.table("./UCI HAR Dataset/features.txt", 
                         fill=FALSE, 
                         strip.white=TRUE)
  featureLabels <- features[,2]
  featureLabels
}

generateTrainData <- function(){
  #Loading training data to Xtrain variable. With the column names as featureLabels
  Xtrain= read.table("./UCI HAR Dataset/train/X_train.txt", 
                     fill=FALSE, 
                     strip.white=TRUE,col.names=featureLabels)  
  # Loading activity training data
  ytrain = read.table("./UCI HAR Dataset/train/y_train.txt", 
                      fill=FALSE, 
                      strip.white=TRUE)  
  # Loading subject training data
  subtrain = read.table("./UCI HAR Dataset/train/subject_train.txt", 
                        fill=FALSE, 
                        strip.white=TRUE)
  # Appending all three training dataframes(activity, subject and measurements) to one, Xtrain
  Xtrain <- cbind(activityid=ytrain[,1],Xtrain)
  Xtrain <- cbind(subject=subtrain[,1],Xtrain)  
  Xtrain  
}

generateTestData <- function(){
  #Loading test data to Xtest variable. With the column names as featureLabels
  Xtest= read.table("./UCI HAR Dataset/test/X_test.txt", 
                    fill=FALSE, 
                    strip.white=TRUE,col.names=featureLabels)
  # Loading activity training data
  ytest = read.table("./UCI HAR Dataset/test/y_test.txt", 
                     fill=FALSE, 
                     strip.white=TRUE)
  #Loading subject test data
  subtest = read.table("./UCI HAR Dataset/test/subject_test.txt", 
                       fill=FALSE, 
                       strip.white=TRUE)
  # Append all three test datasets to one dataframe, Xtest
  Xtest <- cbind(activityid=ytest[,1],Xtest)
  Xtest <- cbind(subject=subtest[,1],Xtest)    
  Xtest  
}

getListOfMeanAndStdCols <- function(featureLabels){
  # Listing all the features which are related to mean()
  meanCols <- grep("mean()",featureLabels,value=T,fixed=TRUE)
  # Listing all the features which are related to std()
  stdCols <- grep("std()",featureLabels,value=T,fixed=TRUE)
  meanandstdCols=c("subject","activityid",meanCols,stdCols)  
  # NOTE: As column names cannot have special characters like "(,),-". So replacing them to "."
  # read.table() replaces the special characters in column names to "." 
  meanandstdCols <- gsub("[[:punct:]]",".",meanandstdCols,perl=TRUE)
  meanandstdCols
}

describeFeatures <- function(featureNames){  
  descriptiveFeatures <- gsub("\\.","",featureNames)  
  descriptiveFeatures <- gsub("(X$)","_X_axis",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Y$)","_Y_axis",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Z$)","_Z_axis",descriptiveFeatures)
  descriptiveFeatures <- gsub("(^t)","time_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(^f)","frequency_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Body)","body_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Gravity)","gravity_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Acc)","acc_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Gyro)","gyro_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Jerk)","jerk_",descriptiveFeatures)
  descriptiveFeatures <- gsub("(Mag)","mag_",descriptiveFeatures)
  descriptiveFeatures
}

generateActivityData <- function(){
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                           fill=FALSE, 
                           strip.white=TRUE,col.names=c("activityid","activity_name"))
  activities
}

  featureLabels <- loadFeatures() 
  # Generate training data having subject, activity ids and measurements.
  Xtrain <- generateTrainData()
  # Generate test data having subject, activity ids and measurements.
  Xtest <- generateTestData()
 
  # Merges the training and the test sets to create one data set.
  mergedData <- rbind(Xtrain,Xtest)

  # Extracting only the measurements on the mean and standard deviation for each measurement
  meanandstdCols <- getListOfMeanAndStdCols(featureLabels)

  # Subsetting the columns which are related to mean() and std()
  meanAndStdData <- mergedData[,meanandstdCols]
   
  # Uses descriptive activity names to name the activities in the data set 
  # Loading activity_labels to a data frame
  activities <- generateActivityData()

  # Adding activity name column to a temporary dataframe, tempData
  meanAndStdData <- merge(activities,meanAndStdData,by="activityid")
  
  # Removing the activity id
  activityDescDf <- subset(meanAndStdData,select=-activityid)
  
  #Appropriately labels the data set with descriptive variable names. 
  descriptiveFeatures <- describeFeatures(names(activityDescDf))

  # Swap order of the subject and activity name to make it more tidy
  activityDescDf <- activityDescDf[,c(2,1,3:68)]
  descriptiveFeatures <- c(descriptiveFeatures[2],descriptiveFeatures[1],descriptiveFeatures[3:68])
  colnames(activityDescDf) <- descriptiveFeatures

  # Creates a second, independent tidy data set with the average of each variable
  # for each activity and each subject. 

  meltedData <- melt(activityDescDf,id=c("subject","activity_name"), 
                     measure.vars = descriptiveFeatures[3:68])

  harTidyData <- dcast(meltedData, subject+activity_name ~ variable, mean)

  # Write the dataframe to a txt format file.
  write.table(harTidyData,file="HAR_MEASURES_AVG.txt",row.names=FALSE,sep=",")


  