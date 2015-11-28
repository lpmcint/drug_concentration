# drug_concentration
Model for the concentration of medicine in blood plasma

###Background###
  In todays society practically everyone will take some form of medicine in his or her life. In fact, most people take medicine every month. It is for this reason that drug dosage is so important. Without proper understanding of drug concentration in the blood plasma, the medications that we have become so dependent on could cause detrimental side effects or even be fatal. These models act as a simplified version of the human body so that a numerical and visual representation of drug concentration in blood plasma can be observed. 
	When calculating the concentration of drug in blood plasma there are many factors to consider. For the sake of simplicity we will focus on drug dose, drug half-life, absorption, and elimination. For all models we will take the plasma volume to be constant and the average for an adult, 3000 ml. We will also take absorption to be a constant at 12%. In order to determine elimination we define a variable eliminationConst and define it as:
```
eliminationConst = -ln(0.5)/ halfLife
```
Note that eliminationConst will vary depending on the drug chosen. Then assume that the rate of change of the drug exiting the system is proportional to the amount of the drug in the system. If we take a variable Q to be the amount of drug in plasma this proportion can be represented as:
```
dQ/dt = -eliminationConst*Q
```
#About the Models#
##One Compartment Model of a Single Dose##
This is a simple one compartment model, with the single compartment representing blood plasma. 
The function OneComparmentSingle takes as parameters halfLife and dose. For each model of single dose we will have the length of the 
simulation to be 8 hours. We start at time t = 0 and calculate in interal DT = .01 for 8 hours. Then take the drugInPlasma at t = 0 to 
be the full dose with no elimination and plasmaConcentration to be the amount of drugInPlasma / plasmaVolume. Two lists are defined to 
keep track of both calculated plasmaConcentration and the time associated with each, and new values are appended after each iteration. 
In each iteration the new elimination and drugInPlasma values are calculated in relation to time and old drugInPlasma value.  The values 
for time and plasmaConcentration are printed, the tList and plasmaConcentrationList values are made into a list of ordered pairs using 
the zip function, and these ordered pairs are then printed as a scatter plot with y-axis in micrograms/milliliter and x-axis in hours.

##Two Compartment Model of a Single Dose##
While a single compartment model can give us a general idea of change in drug concentration over time, the actual concentration values 
are not very accurate. This is because the body is a complex system and our one compartment fails to take into consideration what happens 
as medicine travels through the stomach or intestines before it ever reaches the blood plasma. It is a good estimate however if we were 
to want to see concentration of drugs injected intravenously, because these medicines go straight to the blood stream and do not have to 
bypass any other organs. In order to try to make the model more accurate for oral medicines we can add another compartment. We will let 
this compartment represent the intestines. TwoCompartmentSingle takes the same parameters as OneCompartment single. For the sake of 
simplicity drugInIntestine will be calculated identically to drugInPlasma from the previous models (same elimination, same absorption 
fraction).  We will also assume intestineVolume to be equal to plasmaVolume, and have separate lists to keep track of values for each. 
Now we want to calculate the drugInPlasma in relation to drugInIntestine so we take the rate of absorption for drugInPlasma to be 
proportional to the volume of the intestines multiplied by the difference of drug concentrations in the intestines and plasma. Now we 
can express the rate of change of drugInPlasma as follows:
```
dQ/dt = eliminationConst*intestineVolume*(drugInIntestine – drugInPlasma)
```
Since we have that drugInPlasma is proportional to drugInIntestine we do not need to actually code an added dose for it in the way 
that a dose is added to drugInIntestine. Intestine concentration is represented by green and plasma concentration represented by blue.

##One Compartment Model of Repeated Doses##
Many people do not take medicine just one time so it is also important to understand how drug concentration will change when doses are 
taken repeatedly and long term. We want to see how concentration will change when taking the same dose, with the same half-life 
repeatedly over the course of 10 Days. Similarly to the previous function, OneCompartmentRepeated also takes halfLife and dose as 
paramaters as well as the new parameter interval (hours), to represent the amount of time between doses. This code is relatively similar 
to the code above but now we assume at time t = 0 that drugInPlasma = 0. Changes have also been made so that when the given interval of 
time has passed, a variable named pulse will be set to true and another dose will be added to drugInPlasma. If t is not equal to a 
multiple of the interval, drugInPlasma is calculated as above.

##Two Compartment Model of Repeated Doses##
In this model we want to see how concentration changes while taking repeated doses with a two compartment model. 
The ideas and code here are a combination of the OneCompartmentRepeated function and the TwoCompartmentSingle function.

###Running the Models###
These files are written in Python and run in either Sage Notebooks or the Sage console. Note that extra packages may need to be installed
to see the graphs if the models are run in Sage console. 












