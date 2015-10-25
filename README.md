# GetCleanDataAssignment
* lines 2-4 load required packages into R
* lines 8-13 load datasets into R
* line 16: columnbind the test dataset into a dataframe "test", [subject,activity,measurements]
* line 17: columnbind the train dataset into a dataframe "train", [subject,activity,measurements]
* lines 19-21: read the variable names from "features.txt"
* line 22-23: rowbind the test and train dataset and name the columns
* lines 26-27: extract the columns with "mean()" in the name and assign them to A
* lines 28-29: extract the columns with "std()" in the name and assign them to B
* line 30: combine "Subject", "Activity", A and B into a new dataframe C
* line 31: transform datatype of 1st column from numeric to factor
* line 35-43: replace "1-6" by corresponding activity
* line 44: transform datatype of 2nd column from character to factor
* line 47: give all variables of dataframe C descriptive names
* line 51: create a tall dataframe by stacking all columns from C (3rd through last)
* line 52: create the tidy dataset for step 5 by summarizing over subject and activity
* line 54: write the tidy dataset to a .txt-file