#halfLife = 3.8    #Lortab(Oral)
#dose = 7.5        
#interval = 6      
#halfLife = 22     #Dilantin(Oral) Epilepsy
#dose = 100
#interval = 8
halfLife = 17      #Itraconazole(Oral) Tinea Versicolor
dose = 200
interval = 12

import math
from sage.plot.scatter_plot import scatter_plot

def TwoCompartmentRepeated(halfLife, dose, interval):
    DT = .01
    length = 240
    iterationsPerSec = int(1/DT)
    start = 0
    startIter = 0
    intervalIter = interval*iterationsPerSec
    
    plasmaVolume = 3000
    intestineVolume = 3000
    t = 0
    tList = [0]
    numIterations = int(length/DT) + 1
    
    drugInIntestine = 0
    dose = .12*dose*1000
    drugInPlasma = 0
    eliminationConst = -math.log(0.5) / halfLife
    
    plasmaConcentration = drugInPlasma/ plasmaVolume
    plasmaConcentrationList = [plasmaConcentration]
    intestineConcentration = drugInIntestine / intestineVolume
    intestineConcentrationList = [intestineConcentration]
    intestineElimination = eliminationConst * drugInIntestine
    plasmaElimination = eliminationConst * drugInPlasma
    
    print '       t            PlasmaConcen   IntestineConcen'
    
    if(t == start):
        pulse = True
    else:
        pulse = False
        
    print '%10.2f\t%12.2f\t%12.2f' % (t, plasmaConcentration, intestineConcentration)
    
    for i in range(1, numIterations):
        t = i * DT
        tList.append(t)
        
        if pulse:
            drugInIntestine = drugInIntestine + dose - (intestineElimination)
            intestineConcentration = drugInIntestine / intestineVolume
            intestineConcentrationList.append(intestineConcentration)
        
        else:
            intestineElimination = eliminationConst * drugInIntestine
            drugInIntestine = drugInIntestine - intestineElimination*DT
            intestineConcentration = drugInIntestine / intestineVolume
            intestineConcentrationList.append(intestineConcentration)
            
        plasmaAbsorption = eliminationConst*intestineVolume*(intestineConcentration - plasmaConcentration)*10
        drugInPlasma = plasmaAbsorption - plasmaElimination*DT            
        plasmaConcentration = drugInPlasma / plasmaVolume
        plasmaConcentrationList.append(plasmaConcentration)
        print '%10.2f\t%12.2f\t%12.2f' % (t, plasmaConcentration, intestineConcentration)
        if ((i - (start * iterationsPerSec)) % (interval * iterationsPerSec) == 0):
            pulse = True
        else:
            pulse = False
        
        if (i % 100 == 0):
            print '%10.2f\t%12.2f\t%12.2f' % (t, plasmaConcentration, intestineConcentration)
        
    zipped = zip(tList, plasmaConcentrationList)
    zipped2 = zip(tList, intestineConcentrationList)
    
    scatter1 = scatter_plot(zipped, edgecolor = 'blue', facecolor = 'blue', markersize = 10)
    scatter2 = scatter_plot(zipped2, edgecolor = 'green', facecolor = 'green', markersize = 10)
    
    return scatter1 + scatter2

TwoCompartmentRepeated(halfLife, dose, interval)