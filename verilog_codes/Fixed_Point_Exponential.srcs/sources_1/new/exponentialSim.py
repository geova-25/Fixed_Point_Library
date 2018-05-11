import FixedPoint
from math import exp
import sys
import binary_list_operations as blop

fractional_bits = 15
integer_bits = 17
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
        print format(count, '02d'), ": " , x
        #for y in str(x):
        #    if
        #print format(x,'2s'),
        #print '\n'
        count = count + 1


quantityOfLUTBits = 6
listOfIntegerExp = []
listOfFractionalExp = []
listOfIntegerExpBin = []
listOfFractionalExpBin = []

#---------------------------Integer Lut

fileIntLut = open("binaryIntegerLUT.data","w")
aux = []
for x in range(0,15):
    floatResult = exp(x)
    binaryResult = blop.decimal_to_binary_list(floatResult,fractional_bits,integer_bits)
    fixedResult = blop.binary_list_to_number(binaryResult,fractional_bits,integer_bits)
    newBinaryData = ''
    #for x in range(0,len(binaryResult)-fractional_bits):
    #    newBinaryData += str(binaryResult[x])
    for x in range(0,len(binaryResult)):
        newBinaryData += str(binaryResult[x])
    listOfIntegerExp.append(fixedResult)
    listOfIntegerExpBin.append(newBinaryData)
    #listOfIntegerExpBin.append(binaryResult)

    fileIntLut.write(newBinaryData + '\n')

print "-------------Integer list----------------"
print "-------------Binary----------------"
println(listOfIntegerExpBin)
print "-------------Float----------------"
println(listOfIntegerExp)

#---------------------------Fractional Lut

fileFractLut = open("binaryFractionalLUT.data","w")

aux = []
for x in range(0,64):
    testNumber = blop.decimal_to_binary_list(x,0,quantityOfLUTBits+1)
    resultPerNumber = 0
    counterPerBits = 1
    first = True
    print "----------------------------------------------", x, "---------------------------------------------"
    for bit in testNumber:
        if(not first):
            print "bit: ", bit
            resultPerNumber = resultPerNumber + 2**(-counterPerBits) * int(bit)
            print "resultPerNumber: ", resultPerNumber
            counterPerBits += 1
        else:
            first = False
    first = True
    expResult = float(exp(float(resultPerNumber)))
    expResultList = blop.decimal_to_binary_list(expResult,fractional_bits,integer_bits)

    print "listOriginal: ", testNumber
    print "listExp: ", expResultList
    print x, " : ", resultPerNumber
    print "exp(x): ", x , ": " , expResult
    print "exp(x) Fixed : ", x , ": " , blop.binary_list_to_number(expResultList,fractional_bits,integer_bits)


    binaryResult = blop.decimal_to_binary_list(expResult,fractional_bits,integer_bits)
    newBinaryData = ''
    #for x in range(len(binaryResult)-fractional_bits, len(binaryResult)):
    for x in range(0,len(binaryResult)):
        newBinaryData += str(binaryResult[x])
    listOfFractionalExp.append(expResult)
    listOfFractionalExpBin.append(newBinaryData)
    fileFractLut.write(newBinaryData + '\n')

fileFractLut.close()
fileIntLut.close()

c3Num = 2**-3 + 2**-5 + 2**-7 + 2**-9 + 2**-11 + 2**-13;
c4Num = 2**-5 + 2**-7 + 2**-8

c3 = blop.decimal_to_binary_list(c3Num,fractional_bits,integer_bits)
c4 = blop.decimal_to_binary_list(c4Num,fractional_bits,integer_bits)
c3BinaryData = ''
c4BinaryData = ''
c3List = []
c4List = []

for x in range(0,len(c3)):
    c3BinaryData += str(c3[x])
    c4BinaryData += str(c4[x])


print "-----------------c3: ", c3
print "-----------------c4: ", c4
print "-----------------c3BinaryData: ", c3BinaryData
print "-----------------c4BinaryData: ", c4BinaryData
print "c3Num: ", c3Num
print "c4Num: ", c4Num
print "-------------Fractional list----------------"
print "-------------Binary----------------"
#print "      1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29 30"
print
println(listOfFractionalExpBin)
print "-------------Float----------------"
println(listOfFractionalExp)
