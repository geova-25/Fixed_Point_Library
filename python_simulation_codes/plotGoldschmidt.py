import goldschmidt_division
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
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

A_values_list =  fill_from_to_jumping(0.025,4,0.025)
B_values_list =  fill_from_to_jumping(0.025,4,0.025)
R_values_list_aux = []
R_values_list = []

for x in range(0,quantity_of_values):
    for y in range(0,quantity_of_values):
        R_values_list_aux.append(goldschmidt_division.goldschmidt_division(A_values_list[x],B_values_list[y],28,6)[1])
    R_values_list.append(R_values_list_aux)
    R_values_list_aux = []

'''
print "A_values_list: ", A_values_list
print "B_values_list: ", B_values_list
print "R_values_list: ", R_values_list

print "A_values_list: ", len(A_values_list)
print "B_values_list: ", len(B_values_list)
print "R_values_list: ", len(R_values_list)
'''


ax.set_xlabel('A')
ax.set_ylabel('B')
ax.set_zlabel('%error')

for w in range(0,quantity_of_values):
    for z in range(0,quantity_of_values):
        ax.scatter(A_values_list[w],B_values_list[z],R_values_list[w][z])
plt.show()
