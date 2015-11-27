#halfLife = 2.5    #Morphine(IV) 
#dose = 10         #Morphine(IV)(Every 4 hours)
halfLife = 3.8    #Lortab(Oral)
dose = 20        #Lortab(Oral)
import math
from sage.plot.scatter_plot import scatter_plot

def OneCompartmentSingle(halfLife, dose):
    DT = .01
    length = 8    #hours
    plasmaVolume = 3000 #ml 
    t = 0
    tList = [0]
    numIterations = int(length/DT) + 1
    drugInPlasma = .12 * dose * 1000
    
    eliminationConst = -math.log(0.5) / halfLife
    plasmaConcentration = drugInPlasma / plasmaVolume
    plasmaConcentrationList = [plasmaConcentration]
    
    print "        t       Plasma Concentration"
    print '%10.2f\t%12.2f' % (t, plasmaConcentration)
    
    for i in range(1, numIterations):
        t = i * DT
        tList.append(t)
        elimination = eliminationConst * drugInPlasma
        drugInPlasma = drugInPlasma - elimination * DT
        plasmaConcentration = drugInPlasma / plasmaVolume
        plasmaConcentrationList.append(plasmaConcentration)
        print '%10.2f\t%12.2f' % (t, plasmaConcentration)
        
    zipped = zip(tList, plasmaConcentrationList)
    return(zipped)

x = OneCompartmentSingle(halfLife, dose)
scatter_plot(x, edgecolor = 'black', facecolor = 'black', markersize = 10)