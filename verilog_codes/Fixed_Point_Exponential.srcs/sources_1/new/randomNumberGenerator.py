import random
import binary_list_operations as bl
from math import exp

listRandomFloatsA = []
listRandomFloatsB = []
listRandomBinaryA = []
listRandomBinaryB = []
fractBits = 24
intBits = 8



def generateRandomFloatsDecimalListExp():
    file = open("OperandsDecimalExp.txt","w")
    fileResultDecimalFloatingPoint = open("ResultDecimalFloatingPointExp.txt","w")
    for x in range (0,50):
        randomA = random.uniform(-12.0,4.0)
        listRandomFloatsA.append(randomA)
        file.write(str(format(randomA, '.10f')) + " \n")
        fileResultDecimalFloatingPoint.write(str(format(exp(randomA),'.10f') + " \n"))
        generateRandomBinaryListExp(listRandomFloatsA)
    file.close()

def generateRandomBinaryListExp(listRandomFloats):
    file = open("OperandsBinaryExp.txt","w")
    for x in range (0,len(listRandomFloats)):
        binListA = bl.decimal_to_binary_list(listRandomFloats[x],fractBits,intBits)
        binStringA = bl.binary_list_to_string(binListA)
        listRandomBinaryA.append(binStringA)
        file.write(str(binStringA) + " \n")
    file.close()

def generateRandomFloatsDecimalList():
    file = open("OperandsDecimal.txt","w")
    fileResultDecimalFloatingPoint = open("ResultDecimalFloatingPoint.txt","w")
    for x in range (0,20):
        randomA = random.uniform(-0.001,0.001)
        randomB = random.uniform(-20,20)
        listRandomFloatsA.append(randomA)
        listRandomFloatsB.append(randomB)
        file.write(str(format(randomA, '.10f')) + "   " + str(format(randomB, '.10f')) + " \n")
        fileResultDecimalFloatingPoint.write(str(format(randomA/randomB,'.10f') + " \n"))
        generateRandomBinaryList(listRandomFloatsA, listRandomFloatsB)
    file.close()

def generateRandomBinaryList(listRandomFloatsA, listRandomFloatsB):
    file = open("OperandsBinary.txt","w")
    for x in range (0,len(listRandomFloatsA)):
        binListA = bl.decimal_to_binary_list(listRandomFloatsA[x],fractBits,intBits)
        binListB = bl.decimal_to_binary_list(listRandomFloatsB[x],fractBits,intBits)
        binStringA = bl.binary_list_to_string(binListA)
        binStringB = bl.binary_list_to_string(binListB)
        listRandomBinaryA.append(binStringA)
        listRandomBinaryB.append(binStringB)
        file.write(str(binStringA) + "   " + str(binStringB) + " \n")
    file.close()

#generateRandomFloatsDecimalList()
generateRandomFloatsDecimalListExp()
