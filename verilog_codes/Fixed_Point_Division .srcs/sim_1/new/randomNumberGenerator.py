import random
import binary_list_operations as bl

listRandomFloatsA = []
listRandomFloatsB = []
listRandomBinaryA = []
listRandomBinaryB = []
fractBits = 24
intBits = 8

def generateRandomFloatsDecimalList():
    file = open("OperandsDecimal.txt","w")
    fileResultDecimalFloatingPoint = open("ResultDecimalFloatingPoint.txt","w")
    for x in range (0,20):
        randomA = random.uniform(-0.001,0.001)
        randomB = random.uniform(-10,10)
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

generateRandomFloatsDecimalList()
