.globl __start

.rodata
    msg0: .string "This is HW1-1: \nT(n) = 2T(3n/4) + 0.875n - 137, n >= 10\n"
    msg1: .string "T(n) = 2T(n-1), 1 <= n < 10\nT(0) = 7\n"
    msg2: .string "Enter a number: "
    msg3: .string "The result is: "
.text

__start:
  # Prints msg0
    addi a0, x0, 4
    la a1, msg0
    ecall
  # Prints msg1
    addi a0, x0, 4
    la a1, msg1
    ecall
  # Prints msg2
    li a0, 4
    la a1, msg2
    ecall
  # Reads an int
    addi a0, x0, 5
    ecall

################################################################################ 
  # Write your main function here. 
  # The input n is in a0. 
  # You should store the result T(n) into t0.
  # Round down the result of division.
  
  # HW1_1 
  # T(n) = 2T(3n/4) + 0.875n - 137, n >= 10
  # T(n) = 2T(n-1), 1 <= n < 10
  # T(0) = 7
  
  # EX. addi t0, a0, 1
################################################################################
#result: t0; n: a0

addi s1, s1, 1
addi s2, s2, 2
addi s10, s10, 10
addi s3, s3, 3
addi s4, s4, 4
addi s7, s7, 7
addi s8, s8, 8
fcvt.s.w fs3, s3
fcvt.s.w fs4, s4
fcvt.s.w fs7, s7
fcvt.s.w fs8, s8
jal ra, T
add t0, t0, a0
beq zero, zero, result

T:
    addi sp, sp, -8
    sw a0, 4(sp)
    sw ra, 0(sp)
    bge a0, s10, T10
    bge a0, s1, T1_10
    addi a0, zero, 7
    addi sp, sp, 8
    jalr zero, 0(ra)
    
T1_10:
    addi a0, a0, -1
    jal ra, T
    addi a1, a0, 0
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    mul a0, a1, s2
    jalr zero, 0(ra)
    
T10:
    mul a0, a0, s3
    div a0, a0, s4
    jal ra, T
    addi a1, a0, 0  #a1 = T(3n/4)
    lw a0, 4(sp)  #a0 = n
    lw ra, 0(sp)
    addi sp, sp, 8
    mul a2, a1, s2  #a2 = 2T(3n/4)
    addi a3, a0, 0  #a3 = a0 = n(shallow copy)
    mul a3, a3, s7
    div a3, a3, s8
    add a0, a2, a3  #a0 = 2T(3n/4) + 0.875n
    addi a0, a0, -137  #a0 = 2T(3n/4) + 0.875n - 137
    jalr zero, 0(ra)

result:
  # Prints msg2
    addi a0,x0,4
    la a1, msg3
    ecall
  # Prints the result in t0
    addi a0,x0,1
    add a1,x0,t0
    ecall
  # Ends the program with status code 0
    addi a0,x0,10
    ecall    