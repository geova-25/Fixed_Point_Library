import goldschmidt_division
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import Gnuplot

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

intBits = 12
fractBits = 54
lis_A = []
list_B = []
quantity_of_values = 0 #Quantity of values that each list has
# Falta dividir en quantity of values diferentes para A y B para que
# Puedan tener distintos largos

def fill_from_to_jumping(A,B,C):
    counter = A;
    global quantity_of_values
    while(counter <= B):
        quantity_of_values =  quantity_of_values + 1
        lis_A.append(counter)
        counter += C
    return lis_A

A_values_list =  fill_from_to_jumping(0.1,10,0.1)
B_values_list =  fill_from_to_jumping(0.1,10,0.1)
R_values_list_aux = []
R_values_list = []

for x in range(0,quantity_of_values):
    for y in range(0,quantity_of_values):
        #print "Actual A: ", A_values_list[x]
        #print "Actual B: ", B_values_list[y]
        R_values_list_aux.append(goldschmidt_division.goldschmidt_division(A_values_list[x],B_values_list[y],fractBits,intBits)[1])
    R_values_list.append(R_values_list_aux)
    R_values_list_aux = []

print "Done all calculations..."
print "Starting plotting"

'''
print "A_values_list: ", A_values_list
print "B_values_list: ", B_values_list
print "R_values_list: ", R_values_list

print "A_values_list: ", len(A_values_list)
print "B_values_list: ", len(B_values_list)
print "R_values_list: ", len(R_values_list)
'''
# All data saved here
newFile = open("data.dat","w")
for w in range(0,quantity_of_values):
    for z in range(0,quantity_of_values):
        newFile.write(str(A_values_list[w]))
        newFile.write(" ")
        newFile.write(str(B_values_list[z]))
        newFile.write(" ")
        newFile.write(str(R_values_list[w][z]))
        newFile.write("\n")
        ax.scatter(A_values_list[w],B_values_list[z],R_values_list[w][z])


#-------------------------------------------------------Plotting
stringTitle = "Goldschmidt Division Error % with " + "Integer bits: " + str(intBits) + " Fractional bits: " + str(fractBits)
stringA = "A (Dividendo)"
stringB = "B (Divisor)"
stringError = "Error (%)"
#---------------------------------------Gnu Plotting (Faster but uglier)
g = Gnuplot.Gnuplot()
g.title(stringTitle)
g.xlabel(stringA)
g.ylabel(stringB)
g("set zlabel \"Error (%) \" rotate")
g("set terminal x11 persist")
g("set dgrid3d 10,00")
g("set hidden3d")
g("set ztics rotate right")
g('splot "data.dat" u 1:2:3 with lines')
#Used to plot interative directly in Terminal
#set dgrid3d 50,50; set hidden3d; set ztics rotate right;splot "data.dat" u 1:2:3 with lines
#--------------------------------------matplot
'''
ax.set_xlabel(stringA)
ax.set_ylabel(stringB)
ax.set_zlabel(stringError)
plt.show()
'''
#-----------------------------------------------------
print "Done"
