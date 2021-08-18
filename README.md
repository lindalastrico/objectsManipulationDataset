# Multi-modal Objects Manipulation Dataset

## Kinematic and multi-view representation of human manipulation of objects with variable weight and fragility level

The Multi-modal Objects Manipulation Dataset contains Motion Capture (MoCap) data, inertial data, and multi-view images sequences acquired during the manipulation of different objects in a pick and place task. The objects being manipulated were identical in shape and material, but differed for their weight and for the carefulness required in the handling. Four plastic glasses were variably filled with screws, coins and water to obtain two levels of weight (light - W1, heavy - W2) and of care required in their transportation (filled with water - Careful C, without water - Not Careful NC). The glasses were moved by 15 subjects, seating at a table, in multiple directions and possible elevations.
Each trial consisted of distinguishable phases: reaching for the glass, moving it in the specified position, going back to the resting pose with the hand laying on the table. Each participant performed the same 80 trials, balancing the direction of the movements and the properties of the handled objects. The data coming from the different sensors are synchronized and a common timestamp is given, thanks to the middleware YARP used for the dataset acquisition.

A schematic annotation file is provided, where is specified the sequence of gestures performed by all the 15 volunteers and the charactheristics of each trial (which object was being handled, where the movement started and where the object was delivered).

- The functions "loadMocap" and "loadInertial" allow the user to load and save the data of the respective sensor in an easy-to-use data structure organized in as many rows as the subjects number (15) and as many columns as the trials acquired (80). 
- The function "createVideo" allows to create a video clip from the images acquired for a specific participant and trial, the output is saved in the specified folder. 
- "animatedPlot" renders a previously created wideo together with the markers on the hand. The 3D trajectories and the video are reproduced simultaneously
- The function "loadTimestampsCameras" saves in a data structure the YARP timestamp of each one of the 3 cameras during the experiment. 
- "visualizeHandTrajectory" returns a 3d plot of the hand markers trajectory for a specific trial and participant.
