Manual for Face Recognition Module

1. Change your current working directory of MATLAB to this folder.

2. To normalise the intial images run normalize.m 
	the decription of the code can be found in normalize.m file.
	to read the decription type "help normalize.m"
 (this step is already done and images are classified in train_images and test_images folder
	so, you can skip this step, as this is done!)

3. The GUI can be run by running "facerecog.m" file
	The instructions for running the GUI are made avaialble in the GUI front end
	so that you can refer the instructions without looking README

4. The GUI contains individual modules like 
	createTrainDataBase.m
	featurevector.m
	recognize.m
   The descirption of these functions is given in code and you can read by typing "help <function_name>"

5. The code to find accuracy is written separately to find accuracy for all k first images detected.
	The code is in recognize_accuracy.m
	The description of code is given in code itself and can be read by running "help recognize_accuracy.m"

