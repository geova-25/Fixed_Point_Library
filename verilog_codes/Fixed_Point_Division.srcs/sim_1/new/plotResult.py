import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import Gnuplot


listOfResultsFloating = []
listOfResultsFixed = []
listOfOperandsA = []
listOfOperandsB = []
listOfErrorPercentage = []
listOfClockCicles = []

fileResultForPlotting = open("ResultsForPlotting.data","w")
fileOperandsDecimal = open("OperandsDecimal.txt","r")
fileClockCicles = open("ResultClocks.txt","r")

for line in fileOperandsDecimal:
    listaNew = line.split(' ')
    listOfOperandsA.append(float(listaNew[0]))
    listOfOperandsB.append(float(listaNew[3]))

for line in fileClockCicles:
    listOfClockCicles.append(float(line))


#print "List of listOfOperandsA: \n", listOfOperandsA
#print "List of listOfOperandsB: \n", listOfOperandsB

fileFixed = open("ResultDecimal.txt","r")
for line in fileFixed:
    listOfResultsFixed.append(float(line))
#print "List of Fixed: \n", listOfResultsFixed

fileFloating = open("ResultDecimalFloatingPoint.txt","r")
for line in fileFloating:
    listOfResultsFloating.append(float(line))
#print "List of Floats: \n", listOfResultsFloating

for x in range(0,len(listOfResultsFloating)):
    fileResultForPlotting.write(str(listOfResultsFloating[x]) + " " + str(listOfResultsFixed[x]) + " \n")
    listOfErrorPercentage.append((abs(listOfResultsFloating[x] - listOfResultsFixed[x]) / abs(listOfResultsFloating[x])) * 100)
print "listOfErrorPercentage: ", listOfErrorPercentage
print "listOfClockCicles: ", listOfClockCicles

fig = plt.figure()
#ay = fig.add_subplot(111, projection='3d')
ax = fig.add_subplot(111, projection='3d')
#----------------------Plot values
#ax.scatter(listOfOperandsA, listOfOperandsB, listOfResultsFloating)
#ax.scatter(listOfOperandsA, listOfOperandsB, listOfResultsFixed)
#----------------------Plot ErrorPercentage
#ax.scatter(listOfOperandsA, listOfOperandsB, listOfErrorPercentage)
ax.scatter(listOfOperandsA, listOfOperandsB, listOfClockCicles)

ax.set_xlabel('A Operand')
ax.set_ylabel('B Operand')
#ax.set_zlabel('Error %')

#plt.plot(listOfResultsFloating, listOfResultsFixed)
#---------------------------------------Gnu Plotting (Faster but uglier)
#g = Gnuplot.Gnuplot()

#ay.set_xlabel('A Operand')
#ay.set_ylabel('B Operand')
ax.set_zlabel('Clock Cicles')

plt.show()

'''
g.title(stringTitle)
g.xlabel(stringA)
g.ylabel(stringB)
'''
'''g("set terminal x11 persist")
g("set xrange [-10:10]")
g("set yrange [-10:10]")
g("set datafile separator " "")
#g("set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5 ")
g('plot "ResultsForPlotting.data"')
'''
#g.plot(listOfResultsFixed,listOfResultsFloating)

'''
g("set zlabel \"Error (%) \" rotate")
g("set terminal x11 persist")
g("set dgrid3d 10,10")
g("set hidden3d")
g("set ztics rotate right")
g('splot "data.dat" u 1:2:3 with lines')
#Used to plot interative directly in Terminal
#set dgrid3d 50,50; set hidden3d; set ztics rotate right;splot "data.dat" u 1:2:3 with lines
'''
#--------------------------------------matplot

#-----------------------------------------------------
print "Done"
