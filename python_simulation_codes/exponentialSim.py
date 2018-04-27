from math import exp
import sys
import binary_list_operations as blop

fractional_bits = 24
integer_bits = 8

listExp =  blop.decimal_to_binary_list(exp(0.632218544),fractional_bits,integer_bits)
fpNumber = blop.binary_list_to_number(listExp,fractional_bits,integer_bits);
print "listExp: ", listExp
print "fpNumber: ", fpNumber
