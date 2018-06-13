import binary_list_operations as bl

def convertBinaryResultToDecimal(wordLength,fractBits):
    fileResultBinary = open("ResultBinaryExp.txt", "r")
    fileResultDecimal = open("ResultDecimalFixedPointExp.txt", "w")
    intBits = wordLength -fractBits
    counter = 0
    result = 0;
    for line in fileResultBinary:
        line = list(str(line)[:wordLength])
        for x in range(0,len(line)):
            line[x] = int(line[x])
        result = bl.binary_list_to_number(line, fractBits,  wordLength-fractBits)
        fileResultDecimal.write(str(format(result,'.10f')) + " \n")
        counter += 1
    fileResultBinary.close()
    fileResultDecimal.close()
convertBinaryResultToDecimal(32,24)
