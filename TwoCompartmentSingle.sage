#halfLife = 2.5    #Morphine(IV) 
#dose = 10         #Morphine(IV)(Every 4 hours)
halfLife = 3.8    #Lortab(Oral)
dose = 7.5        #Lortab(Oral)(Every 6 hours)
#halfLife = 22     #Dilantin(Oral) Epilepsy
#dose = 100
#interval = 8

import math
from sage.plot.scatter_plot import scatter_plot

def TwoCompartmentSingle(halfLife, dose):
    DT = .01
    length = 8
    plasmaVolume = 3000
    intestineVolume = 3000
    t = 0
    tList = [0]
    numIterations = int(length/DT) + 1
    
    drugInIntestine = .12*dose*1000
    drugInPlasma = 0
    eliminationConst = -math.log(0.5) / halfLife
    
    
    plasmaConcentration = drugInPlasma/ plasmaVolume
    plasmaConcentrationList = [plasmaConcentration]
    intestineConcentration = drugInIntestine / intestineVolume
    intestineConcentrationList = [intestineConcentration]
    
    print '       t            PlasmaConcen   IntestineConcen'
    
    for i in range(1, numIterations):
        t = i * DT
        tList.append(t)
        
        intestineElimination = eliminationConst * drugInIntestine
        drugInIntestine = drugInIntestine - intestineElimination*DT
        intestineConcentration = drugInIntestine / intestineVolume
        intestineConcentrationList.append(intestineConcentration)
        
        plasmaAbsorption = eliminationConst*intestineVolume*(intestineConcentration - plasmaConcentration)           
        plasmaElimination = eliminationConst * drugInPlasma
        drugInPlasma = plasmaAbsorption - plasmaElimination*DT
        plasmaConcentration = drugInPlasma / plasmaVolume
        plasmaConcentrationList.append(plasmaConcentration)
        print '%10.2f\t%12.2f\t%12.2f' % (t, plasmaConcentration, intestineConcentration)
        
    zipped = zip(tList, plasmaConcentrationList)
    zipped2 = zip(tList, intestineConcentrationList)
    
    scatter1 = scatter_plot(zipped, edgecolor = 'blue', facecolor = 'blue', markersize = 10)
    scatter2 = scatter_plot(zipped2, edgecolor = 'green', facecolor = 'green', markersize = 10)
    
    return scatter1 + scatter2

TwoCompartmentSingle(halfLife, dose)