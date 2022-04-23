# Classifying the Right-Of-Way for San Francisco
*CPLN 650 Final Project* <br>by Alexander Nelms

## Summary
For my final project, I will be performing right-of-way semantic segmentation of satellite imagery. I want to understand which areas of the City of San Francisco are roads/right-of-way. I already have a polygon dataset of those right-of-ways, but I still need to find a proper set of rgb satellite images before cleaning them and developing the U-net model. 

## Deliverables
| Date | Project | Location |
| :---: | :--- | :---: |
| Apr 11 | **Project Proposal 0** | [*PDF*](https://github.com/nelmsal/MUSA650_FinalProject_RightOfWayClassification/blob/main/deliverables/Nelms%20-%20Preliminary%20Report.pdf) |
| Apr 22 | **Progress Report** | [*PDF*](https://github.com/nelmsal/MUSA650_FinalProject_RightOfWayClassification/blob/main/deliverables/Nelms%20-%20Progress%20Report.pdf) |
| May 2 | **Final Report** |  |
| Mar 2 | **Presentation** |  |
| Mar 10 | **Discussions** |  |
| Mar 10 | **Project Chats** |  |


##Project Steps

*Find Data*
1.	~~Create Github~~
2.	~~Find Right-of-Way Polygons for San Francisco [(San Francisco Open GIS)](https://data.sfgov.org/City-Infrastructure/Right-of-Way-Polygons/a2mg-gwmg)~~
3.	Find Satellite Images that are granular, have multiple channels, and are newer than 2015

*Data Preparation* 
4.	Create a mask from the Right-of-Way (RoW) Polygons based on the shape of the satellite images
5.	Cut the RoW masks & satellite images into the same sized windows
6.	Process the satellite images into matrices 

*Develop & Fit the Model* 
7.	Start with a U-net architecture for the model. Then potentially look into alternatives
8.	Fit the model
9.	Analyze the accuracy then re-evaluate the model
