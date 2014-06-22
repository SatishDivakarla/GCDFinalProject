Code Book
========================================================

### Introduction:
This document describes the R script run_analysis.R This script is used to clean the "Human Activity Recognition Using Smartphones Data Set" to a tidy format. 

### Libraries:
plyr - For proper execution of this script,plyr package should be installed in your local machine. The following command can be used to install plyr package
```
 install.packages("plyr")
```

### Helper functions:

#### loadFeatures() : 
  Reads features.txt and  extract feature labels from the file. This method returns a factor of feature labels
  
#### generateTrainData() : 
  This method generates the datframe having training set. This method reads three files X_train.txt, y_train.txt and subject_train.txt and returns a dataframe having the combined columns of three files.
  
#### generateTestData() : 
  This method generates the datframe having test set. This method reads three files X_test.txt, y_test.txt and subject_test.txt and returns a dataframe having the combined columns of three files.
  
#### getListOfMeanAndStdCols() :
  This method returns a list of columns related to mean() and std() in the measurements collected in X_train.txt and X_test.txt
  
#### describeFeatures() : 
  This method accepts the column names and rename them to more descriptive names for better readability. The new names are defined mainly by following few rules:
  1. Names should have only characters and "_"
  2. Short forms like t, f are replaced with time and body resply.
  3. Added a word "axis" at the end for all columns which ends with either X or Y or Z. This is followed because they represent the measurements for the X, Y and Z axis.
  4. For readability, all characters are in small letters
  
#### generateActivityData() :
Reads activity_labels.txt and  extract feature labels from the file. This method returns a dataframe called ACTIVITIES, which contains two columns, activity_id and activity_name.

### Important Variables/Constants:
* mergedData: 
This dataframe combines the data from train and test datasets. It also contains the output class(y*txt) and subject details(subject*txt). This data frame contains 563 columns and 10299 observations. 

* activities:
   This dataframe contains the details of activity labels returned by generateActivityData() function. This dataframe contains two columns, activity_id and activity_name.

* meanAndStdData : 
      This dataframe contains only the rows which are related to mean() and std() of the measurements collected in training and test datasets. It has 10299 observations with only 68 columns. Two out of these 68 columns are subject_id and activity_id.
      
      This dataframe is later merged with activities data to replace the activy_ids with activity_names.
      
* meltedData:
    To construct a tidy data set having the average of measurements for each subject and activity we need to melt the data set with ids as activity_name and subject_id and remaining columns as variables.
    
* harTidyData: 
  The above mentioned meltedData is in turn casted to perform the average on variables for each subject and activity_names.

### Important manipulations to the datasets:
To replace the activity ids to activty_names in the tidy dataset, the following algorithm is used:
* include plyr library
* Add a new column, activity_name by merging meanAndStdData and activities dataframes.
* Remove the activity_id column
* Reordered the columns such that the first two columns are subject and activity_name.

### Output:
The output of run_analysis.R script is a coma seperated text file. The final tidy dataset containing the 180 observations and 68 columns are written to HAR_MEASURES_AVG.txt file.


### Citations:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.