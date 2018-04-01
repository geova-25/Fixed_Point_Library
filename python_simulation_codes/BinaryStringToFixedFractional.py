
def Bin2FF(decimal,stringBin):
    listBin = list(stringBin)
    result = 0
    for x in range(0,len(listBin)):
        #print "listBin[len(listBin) - 1 - x]: ", int(listBin[x])
        result = result + 2**-(x+1) * int(listBin[x])
    print stringBin, ': ' , result
    return result + decimal

print "Result: \n", Bin2FF(0,'101') / Bin2FF(0, '111')
