datasciencecoursera
===================
1 - the script checks if the data dir exists and creates it if it doesn't exists.
2 - Then the dataset is checked, if it doesn't exists it will be downloaded and extracted. If it exists the folder of the data will be checked, if it doesnt exists then it will be extracted.
3 - After the preparation phase the training and data sets will be read to be merged into one.
4 - After the merge, the others steps required are executed.
5 - After the last step the tidy data will be saved to the file tidy_data.txt and the returned.

Notes: I uploaded the dataset inside data dir...to test the script without data, just need to erase the data dir and run it again.