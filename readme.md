Human Activity Recognition Using Smartphones Data Set 
========================================================

This project contains an R script called run_analysis.R. This script reads the dataset placed in project root directory, performs cleaning and creates a new tidy dataset. The data is downloaded from the below location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is expected that the data is downloaded from the above link and extracted to a folder "UCI HAR Dataset". 
This folder should be present in the same location as "run_analysis.R". 

```
The directory structure for the project is as follows:
run_analysis.R
  - UCI HAR Dataset
	- UCI HAR Dataset/test:
	- UCI HAR Dataset/test/Inertial Signals
	- UCI HAR Dataset/train:
	- UCI HAR Dataset/train/Inertial Signals
```

#### Steps to execute:
* Checkout this project to your local directory.
* The project root, should contain a R file called, run_analysis.R
* Create a directory named "data" 
* Download the data from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Place the extracted data in the "data" folder. Please refer the directory structure shown above for more details.
* Run the following command in project root directory
  source("run_analysis.R")
* This command creates a file "HAR_MEASURES_AVG.txt". This file contains the average of mean and standard deviation measurements for each subject and activity. This file has 180 observations and 68 columns.
*The columns are seperated by a comma ","
* Definition of each variable/column is defined in the codebook.md 
  
#### Note: This project is written and tested with following system configuration
* R version 3.1.0 
* OS : Mac OSX 10.9.3


#### Citations:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.