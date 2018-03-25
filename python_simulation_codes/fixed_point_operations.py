#---------------------------------------This functions are the ones to call
#---------------------------------------to make a shift of a floating Point
#---------------------------------------number as a fixed point
#---------------------------------------
#----------------------------------------Shift fractional right

import binary_list_operations as blop

def shift_Right_Floating(number, fractBits, intBits):
    number_list = blop.decimal_to_binary_list(number,fractBits,intBits)
    shifted_list = blop.shift_R(number_list,fractBits + intBits)
    #print "Original: ", number_list
    #print "Shifted:  ", shifted_list
    final_result = blop.binary_list_to_number(shifted_list,fractBits,intBits)
    return final_result


#----------------------------------------Shift fractional left

def shift_Left_Floating(number, fractBits, intBits):
    number_list = blop.decimal_to_binary_list(number,fractBits,intBits)
    shifted_list = blop.shift_L(number_list,fractBits + intBits)
    #print "Original: ", number_list
    #print "Shifted:  ", shifted_list
    final_result = blop.binary_list_to_number(shifted_list,fractBits,intBits)
    return final_result

#--------------test shift_Left/Right_Floating
'''
number = 6.023456
fractional_bits = 12
integer_bits = 8
total_bits = fractional_bits + integer_bits
print "Left:  ",shift_Left_Floating(number,fractional_bits,integer_bits)
print "Right: ",shift_Right_Floating(number,fractional_bits,integer_bits)
'''
