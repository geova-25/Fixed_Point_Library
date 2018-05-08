import FixedPoint
from math import exp
import sys
import binary_list_operations as blop

fractional_bits = 24
integer_bits = 8
string_to_format = "{0:." +str(12)+"f}"

'''
#------------------------------First Exponential test

listExp =  blop.decimal_to_binary_list(exp(0.632218544),fractional_bits,integer_bits)
fpNumber = blop.binary_list_to_number(listExp,fractional_bits,integer_bits);
print "listExp: ", listExp
print "fpNumber: ", fpNumber
'''

def println(listln):
    count = 0
    for x in listln:
        print count, ":" , x
        count = count + 1


quantityOfLUTBits = 6
listOfIntegerExp = []
listOfFractionalExp = []
listOfIntegerExpBin = []
listOfFractionalExpBin = []

#---------------------------Integer Lut

for x in range(0,15):
    floatResult = exp(x)
    binaryResult = blop.decimal_to_binary_list(floatResult,fractional_bits,integer_bits)
    fixedResult = blop.binary_list_to_number(binaryResult,fractional_bits,integer_bits)
    listOfIntegerExp.append(fixedResult)
    listOfIntegerExpBin.append(binaryResult)
print "-------------Integer list----------------"
println(listOfIntegerExpBin)
println(listOfIntegerExp)

#---------------------------Fractional Lut

for x in range(0,64):
    floatX = float("0." + str(x))
    floatResult = exp(floatX)
    fixedResult = blop.binary_list_to_number(blop.decimal_to_binary_list(floatResult,fractional_bits,integer_bits),fractional_bits,integer_bits)
    listOfFractionalExp.append(exp(floatX))
    listOfFractionalExpBin.append(blop.decimal_to_binary_list(fixedResult,24,8))
print "-------------Fractional list----------------"
println(listOfFractionalExpBin)
println(listOfFractionalExp)

def getLutIntByIndex(index):
    return listOfIntegerExp[index]

def getLutFractByIndex(index):
    return listOfFractionalExp[index]

def fpMult(a,b,fractBits,intBits):
    Family = FixedPoint.FXfamily(fractBits,intBits)
    a = FixedPoint.FXnum(a,Family)
    b = FixedPoint.FXnum(b,Family)
    return float(string_to_format.format(float(a*b)))

def getLutsValue(num,fractBits,intBits):
    xBinList = blop.decimal_to_binary_list(A, fractBits, intBits)
    resultFractional1 = 0
    counter = 1
    resultInteger = int(num)
    #println(xBinList)
    for x in range(intBits,intBits + quantityOfLUTBits): # six is the quantity of bits that I will use for LUT
        resultFractional1 += 2**counter*xBinList[x]
        #print "counter: ", counter , "xBinList: ", xBinList[x]
        counter = counter + 1;
    #print "resultFractional1: ", resultFractional1
    #print "resultInteger: ", resultInteger
    return getLutIntByIndex(resultInteger), getLutFractByIndex(resultFractional1)

A = 5.454

def getPolinomialValue(num, fractBits, intBits):
    xBinList = blop.decimal_to_binary_list(A, fractBits, intBits)
    result = 0
    counter = 1
    #println(xBinList)
    for x in range(intBits + quantityOfLUTBits,intBits + fractBits): # six is the quantity of bits that I will use for LUT
        result += 2**counter*xBinList[x]
        #print "counter: ", counter , "xBinList: ", xBinList[x]
        counter = counter + 1;
    return result


def getThisBits(quantityOfBits, num): # Me da los primeros bits
    counter = 0;
    binList = str(bin(num)).split('0b')[1]
    result = []
    print binList
    for x in range(0, quantityOfBits):
        if(x >= len(binList)):
            return result
        else:
            #result.append(int(binList[len(binList)-1-x]))
            result.insert(0,int(binList[len(binList)-1-x]))
    return result

'''
quantityOfXbits = 9
quantityOfX2bits = 18
quantityOfX3bits = 13
quantityOfX3bits = 7

intLutValue =  getLutsValue(A,fractional_bits,integer_bits)[0]
fractLutValue =  getLutsValue(A,fractional_bits,integer_bits)[1]
xValue =  getPolinomialValue(A,fractional_bits,integer_bits) ##-------------------------------Here change list to number decimal
x2Value = getThisBits(quantityOfX2bits, xValue * xValue)
x3Value = getThisBits(quantityOfX3bits, x2Value * xValue)
x4Value = getThisBits(quantityOfX4bits, x3Value * xValue)
print "intLutValue: ", intLutValue
print "fractLutValue: ", fractLutValue
print "x: ", xValue
print "x2: ", x2Value
print "x3: ", x3Value
print "x4: ", x4Value
'''

#print getThisBits(9,2)


#print "IntLutValue: ",
#print fpMult(A,B)












'''
Dividend = FixedPoint.FXnum(A,Family)
Divisor = FixedPoint.FXnum(B,Family)
A = blop.binary_list_to_number(blop.decimal_to_binary_list(1.02124023437,12,8),12,8)
B = blop.binary_list_to_number(blop.decimal_to_binary_list(12.02978515625,12,8),12,8)
print A
print  string_to_format.format(float(Dividend*Divisor))
'''
#println(listOfIntegerExp)
#println(listOfFractionalExp)
