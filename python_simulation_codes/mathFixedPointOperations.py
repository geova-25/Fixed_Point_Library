
def add_binary(op_a,op_b,word_number):
    op_result = [0]*word_number
    carry = 0
    carry_aux = 0
    for x in range(0, word_number):
        if(op_a[word_number - 1 - x] == op_b[word_number - 1 - x] and (op_a[word_number - 1 - x] == 1 or op_b[word_number - 1 - x] == 1)):
            if(carry == 1):
                op_result[word_number - 1 - x] = 1
                carry_aux = 1
            else:
                op_result[word_number - 1 - x] = 0
                carry_aux = 1
        elif(op_a[word_number - 1 - x] == op_b[word_number - 1 - x] and (op_a[word_number - 1 - x] == 0 or op_b[word_number - 1 - x] == 0)):
            if(carry == 1):
                op_result[word_number - 1 - x] = 1
                carry_aux = 0
            else:
                op_result[word_number - 1 - x] = 0
                carry_aux = 0
        elif((op_a[word_number - 1 - x] != op_b[word_number - 1 - x]) and (op_a[word_number - 1 - x] == 1 or op_b[word_number - 1 - x] == 1)):
            if(carry == 1):
                op_result[word_number - 1 - x] = 0
                carry_aux = 1
            else:
                op_result[word_number - 1 - x] = 1
                carry_aux = 0
        else:
            if(carry == 1):
                op_result[word_number - 1 - x] = 0
                carry_aux = 1
            else:
                op_result[word_number - 1 - x] = 1
                carry_aux = 0
        carry = carry_aux
    return op_result
