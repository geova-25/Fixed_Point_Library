import FixedPoint
from operator import mul
import fixed_point_operations as fpOp
import math

active_prints = 1
def printGolds(a,b):
    if (active_prints):
        print a, b


def goldschmidt_division(dividendo,divisor,fractional,integer):
    string_to_format = "{0:." +str(fractional)+"f}"
    Family = FixedPoint.FXfamily(fractional,integer)
    One = FixedPoint.FXnum(1,Family)
    two = FixedPoint.FXnum(2,Family)
    totalBits = integer + fractional
    Dividend = FixedPoint.FXnum(dividendo,Family)
    Divisor = FixedPoint.FXnum(divisor,Family)
    Terminal_condition = FixedPoint.FXnum(0.999,Family)
    fAproximation = Divisor
    counter = 0

    printGolds("Dividend: ", string_to_format.format(float(Dividend)))
    printGolds("Divisor: ", string_to_format.format(float(Divisor)))

    Terminal_Condition = float(string_to_format.format(float(Terminal_condition)))

    printGolds("Terminal_Condition: ", Terminal_Condition)
    printGolds("Finit: ", string_to_format.format(float(fAproximation)))
    Divisor_Aux = Divisor
    while(fAproximation > 1):
    #while(counter != 7):
        counter = counter + 1

        printGolds("Corrimientos: ", counter)

        Dividend = fpOp.shift_Right_Floating(float(string_to_format.format(float(Dividend))),fractional,integer)
        Divisor  = fpOp.shift_Right_Floating(float(string_to_format.format(float(Divisor))),fractional,integer)
        #Dividend = float(string_to_format.format(float(Dividend / two)))
        #Divisor = float(string_to_format.format(float(Divisor / two)))
        #print "Dividend: ", Dividend
        #print "Divisor: ", Divisor
        fAproximation = Divisor
        #Divisor_Aux = Divisor_Aux >> 1
        #fAproximation = Divisor_Aux >> 1
    printGolds("fAproximation: ", string_to_format.format(float(fAproximation)))
    printGolds("Divisor: ", string_to_format.format(float(Divisor)))
    printGolds("Dividend: ", string_to_format.format(float(Dividend)))
    #print Family.resolution #Me da la resolucion (numero de bits fraccionales)

    counter = 0
    log2n = int(math.log(totalBits,2))
    result_final = 0
    error = 0
    real_value = 0
    while(Divisor<Terminal_condition):
    #while(counter != 15):

        printGolds("Iteration #" + str(counter + 1), "--------------------")

        Dividend = Dividend * fAproximation
        Divisor  = Divisor * fAproximation
        fAproximation = two - Divisor
        counter += 1

        printGolds("Dividend: ", string_to_format.format(float(Dividend)))
        printGolds("Divisor: ", string_to_format.format(float(Divisor)))
        printGolds("fAproximation: ", string_to_format.format(float(fAproximation)))

        result_final = float(string_to_format.format(float(Dividend)))
        real_value = dividendo/float(divisor)
        error = round((math.fabs(real_value - result_final)/real_value)*100,5)

        printGolds("Real: ", real_value)
        printGolds("Result: ", result_final)
        printGolds("Error % : ", error)
    return result_final,error,real_value


#-----------------------------test

A = 0.5
B = 7

division_Result = goldschmidt_division(A,B,24,8)

#printGolds("Real: ", division_Result[0])
#printGolds("Result: ", division_Result[2])
#printGolds("Error % : ", division_Result[1])
