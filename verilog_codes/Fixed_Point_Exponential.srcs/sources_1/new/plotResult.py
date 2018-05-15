import matplotlib.pyplot as plt
import numpy as np
import Gnuplot

listOfResultsFloating = []
listOfResultsFixed = []
listOfOperandsA = []
listOfErrorPercentage = []

fileResultForPlotting = open("ResultsForPlotting.data","w")
fileOperandsDecimal = open("OperandsDecimalExp.txt","r")

for line in fileOperandsDecimal:
    listaNew = line.split(' ')
    listOfOperandsA.append(float(listaNew[0]))


#print "List of listOfOperandsA: \n", listOfOperandsA
#print "List of listOfOperandsB: \n", listOfOperandsB

fileFixed = open("ResultDecimalFixedPointExp.txt","r")
for line in fileFixed:
    listOfResultsFixed.append(float(line))
#print "List of Fixed: \n", listOfResultsFixed

fileFloating = open("ResultDecimalFloatingPointExp.txt","r")
for line in fileFloating:
    listOfResultsFloating.append(float(line))
#print "List of Floats: \n", listOfResultsFloating

for x in range(0,len(listOfResultsFloating)):
    errorPercentage = (abs(listOfResultsFloating[x] - listOfResultsFixed[x]) / abs(listOfResultsFloating[x])) * 100
    fileResultForPlotting.write(format(str(listOfResultsFloating[x]), '15s') + "\t" + format(str(listOfResultsFixed[x]),'15s') + "\t" + format(str(errorPercentage),'15s') + " \n")
    listOfErrorPercentage.append(errorPercentage)
print "listOfErrorPercentage: ", listOfErrorPercentage
print "listOfResultsFixed: ", listOfResultsFixed
print "listOfResultsFloating: ", listOfResultsFloating


plt.xlabel('Operand')
plt.ylabel('Error Percentage')
plt.plot(listOfOperandsA, listOfErrorPercentage, 'ro')
#---------------------------------------Gnu Plotting (Faster but uglier)
#g = Gnuplot.Gnuplot()

#ay.set_xlabel('A Operand')
#ay.set_ylabel('B Operand')

plt.show()

#-----------------------------------------------------
print "Done"
