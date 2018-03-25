
def fill_array_sized(array, value, bits_quantity):
    for x in range(0,bits_quantity):
        array.append(value)
    return array

def binary_list_to_number(list_number, fractBits,intBits):
    totalData = list_number
    result = 0
    for x in range(0, intBits):
        result += totalData[x]*2**(intBits-1-x)
    for x in range(0, fractBits):
        result += totalData[x+intBits]*2**-(x+1)
    return result

def decimal_to_binary_list(decNumber,fractBits,intBits):
    intData   = [0]*intBits
    fractData = [0]*fractBits
    totalData = []
    onlyDec = int(decNumber)
    onlyFractional = decNumber - onlyDec
    for x in range(0, fractBits):
        #print "onlyFractional: ", onlyFractional
        newBinaryDigit = int(onlyFractional*2)
        #print "newBinaryDigit: ", newBinaryDigit
        onlyFractional = onlyFractional*2 - int(onlyFractional*2)
        fractData[x] = newBinaryDigit
    onlyDec = bin(onlyDec)[2:]
    #print "onlyDec: ", onlyDec
    #print "len onlyDec: ", len(onlyDec)
    for x in range(0, intBits):
        if(x<len(onlyDec)):
            intData[intBits-1-x] = int(onlyDec[len(onlyDec)-1-x])
    totalData.extend(intData)
    #self.totalData.append('.')
    totalData.extend(fractData)
    return totalData

#---------------Test converting binary_list to number and back
'''
print decimal_to_binary_list(1.025,12,8)
print binary_list_to_number(decimal_to_binary_list(1.025,24,8),24,8)
'''

#---------------------------------------------Shift Rigth

def shift_R(op,totalBits):
    anterior = 0
    result = fill_array_sized([],0,totalBits)
    for x in range(1,totalBits-1):
        anterior = op[x]
        result[x+1] = anterior
    return result

#---------------Test shiftRigth
'''
fractional_bits = 12
integer_bits = 8
total_bits = fractional_bits + integer_bits
test_value = decimal_to_binary_list(1.025,fractional_bits,integer_bits)
print "test_value:      ", test_value
print "shifted_R_value: ", shift_R(test_value,total_bits)
'''
#---------------------------------------------Shift Left

def shift_L(op,totalBits):
    anterior = 0
    anterior_aux = 0
    result = fill_array_sized([],0,totalBits)
    for x in range(1,totalBits):
        anterior_aux = op[totalBits - x]
        result[totalBits - x] = anterior
        anterior = anterior_aux
    return result

#---------------Test shiftLeft
'''
fractional_bits = 12
integer_bits = 8
total_bits = fractional_bits + integer_bits
test_value = decimal_to_binary_list(1.025,fractional_bits,integer_bits)
print "test_value:      ", test_value
print "shifted_L_value: ", shift_L(test_value,total_bits)
'''
