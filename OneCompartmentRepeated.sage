#halfLife = 2.5    #Morphine(IV) 
#dose = 10         
#interval = 4      
#halfLife = 3.8    #Lortab(Oral)
#dose = 7.5        
#interval = 6      
halfLife = 22     #Dilantin(Oral) Epilepsy
dose = 100
interval = 8
#halfLife = 17      #Itraconazole(Oral) Tinea Versicolor
#dose = 200
#interval = 12

import math
from sage.plot.scatter_plot import scatter_plot

def OneCompartmentRepeated(halfLife, dose, interval):
    DT = .01
    length = 240    #hours
    numIters = int(length/DT) + 1
    iterationsPerSec = int(1/DT)
    start = 0
    startIter = 0
    intervalIter = interval*iterationsPerSec
    
    volume = 3000    #ml
    t = 0
    tList = [0]  
    
    drugInPlasma = 0
    dose = .12 * dose * 1000
    eliminationConst = -math.log(0.5) / halfLife
    plasmaConcentration = drugInPlasma / volume
    plasmaConcentrationList = [plasmaConcentration]
    elimination = eliminationConst * drugInPlasma
    
    print "      t          Concentration"
    
    if(t == start):
        pulse = True
    else:
        pulse = false
    print '%10.2f\t%12.2f' % (t, plasmaConcentration)
    
    for i in range(1, numIters):
        t = i * DT
        tList.append(t)
        if pulse:
            drugInPlasma = drugInPlasma + dose - (elimination) * DT
        else:
            drugInPlasma = drugInPlasma - (elimination) * DT
        plasmaConcentration = drugInPlasma / volume
        plasmaConcentrationList.append(plasmaConcentration)
        if ((i - (start * iterationsPerSec)) % (interval * iterationsPerSec) == 0):
            pulse = True
        else:
            pulse = False
        elimination = eliminationConst * drugInPlasma
        
        if (i % 100 == 0):
            print '%10.2f\t%12.2f' % (t, plasmaConcentration)
            
    zipped = zip(tList, plasmaConcentrationList)
    return(zipped)

x = OneCompartmentRepeated(halfLife, dose, interval)
scatter_plot(x, facecolor = 'black', markersize = 10)