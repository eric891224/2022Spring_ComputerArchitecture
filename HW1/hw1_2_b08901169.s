.globl __start

.rodata
    msg0: .string "This is HW1_2: \n"
    msg1: .string "Plaintext: "
    msg2: .string "Ciphertext: "
.text

################################################################################
# print_char function
# Usage: 
#     1. Store the beginning address in x20
#     2. Use "j print_char"
#     The function will print the string stored from x20 
#     When finish, the whole program will return value 0
print_char:
    addi a0, x0, 4
    la a1, msg2
    ecall
    
    add a1, x0, x20
    ecall
# Ends the program with status code 0
    addi a0, x0, 10
    ecall
################################################################################
################################################################################
__start:
# Prints msg
    addi a0, x0, 4
    la a1, msg0
    ecall
    
    la a1, msg1
    ecall
    
    addi a0, x0, 8  #ecall code 8: read string
    
    li a1, 0x10130  #input string buffer address
    addi a2, x0, 2047  #buffer length
    ecall
# Load address of the input string into a0
    add a0, x0, a1
################################################################################   
################################################################################ 
# Write your main function here. 
# a0 stores the beginning Plaintext
# Do store 66048(0x10200) into x20 
cipher:
    li x20, 0x10200  #output text buffer address (s4 used)
    addi s1, zero, 10  #ascii of '\n'
    addi s2, zero, 0x6e  #ascii of 'n'
    addi s3, zero, 9  #s3 = counter of comma from 9 to 0
    addi s3, s3, 48  #s3 = ascii of counter of comma from 9 to 0
    addi s5, zero, 0x2c  #ascii of ','
    addi t0, zero, 0  #let t0 be i=0
    
iter:
    add t1, t0, a0  #t1 = &(a0[i])
    add t2, t0, x20  #t2 = &(cipher[i])
    lb a2, 0(t1)    #a2 = ascii of string[i]
    beq a2, s5, comma  #go to comma handling part
    bge a2, s2, after_n  #go back to 'A' if exceeded
    beq a2, s1, end  #print cipher if reach end of string(\n)
    addi a3, a2, -19  #cipher the text by -19(diff. of 'a' to 'N')
    sb a3, 0(t2)  #store ciphered char to cipher[i]
    addi t0, t0, 1  #i += 1
    beq zero, zero, iter

after_n:
    addi a3, a2, -45  #cipher the text by -45(diff. of 'n' to 'A')
    sb a3, 0(t2)
    addi t0, t0, 1
    beq zero, zero, iter
    
comma:
    add a3, zero, s3  #a3 = current counter of comma
    sb a3, 0(t2)
    addi t0, t0, 1
    addi s3, s3, -1  #counter -= 1
    beq zero, zero, iter
    
end:  
    j print_char    
################################################################################    
