Purpose of CodeBook: Describe the variables, data, and any transformations or work that I performed to clean up the data.


STEP 1: MERGE TRAINING AND TEST DATA SETS

Transformations:
i) Read training data files for measurements, subjects' IDs, and the corresponding activities as dataTrain, IDTrain, and ActivityTrain respectively.
ii) Did the same for the test data files.
iii) Additionally, read in the variable names as featureNames.
iv) Combined the data files dataTrain and dataTest - this is now the combined set of measurements, across all 561 variables, for both training and test subjects.


STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
 
Transformations:
i) Identified the relevant variables (ie. related to "mean" and "std") and stored these in a featureNames_extract vector.
ii) Based on these variables identified to be relevant, generate a new combined data file, CombinedData_extract.


STEP 3: LABEL DATA SET WITH DESCRIPTIVE VARIABLE NAMES

Transformations:
i) Based on featureNames_extract from Step 2(i), replace row names for CombinedData_extract.


STEP 4: CREATE A SECOND INDEPENDENT TIDY DATA SET, WITH THE AVERAGE OF VARIABLES FOR EACH ACTIVITY AND EACH SUBJECT

Transformations:
i) rbind subjects' IDs, for both training and test.
ii) rbind Activities, for both training and test.
iii) cbind (i), (ii), and CombinedData_extract.
iv) Use melt and dcast to compute the means.

