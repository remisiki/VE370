.data
arr: .word 47,40,4,48,0,0,21,26,0,-18,26,0,0,-46,27,32,-45,-19,0,41,0,14,-21,28,-37,0,38,21,0,-18,0,0,0,-12,18,-39,-29,26,0,-1

str1: .string "Count of positive numbers is "
str2: .string "Count of negative numbers is "
str3: .string "Count of zero is "
str4: .string "Sum of all numbers is "
strn: .string "\n"

.text
main:
    addi s0, x0, 40 # size of arr
    lui s1, 0x10000 # address of arr

    # parse function arguments
    # a1: arr
    # a2: sizeof(arr)
    add a1, x0, s1
    add a2, x0, s0
    
    # print str1
    lui s2, 0x10000
    addi s2, s2, 0xa0
    addi s3, x0, 29
    addi a7, x0, 11
    printString1:
        add t0, t1, s2
        lb a0, 0(t0)
        ecall
        beq t1, s3, exitPrint1
        addi t1, t1, 1
        jal x0, printString1
    exitPrint1:

    # count positive numbers
    addi a3, x0, 1
    jal x1, countArray
    addi a7, x0, 1
    ecall
    add s4, a0, x0 # save posCnt to s4
    
    # newline
    addi s2, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0x105
    lb a0, 0(s2)
    addi a7, x0, 11
    ecall
    
    # print str2
    addi s2, x0, 0
    addi t1, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0xbe
    addi s3, x0, 29
    addi a7, x0, 11
    printString2:
        add t0, t1, s2
        lb a0, 0(t0)
        ecall
        beq t1, s3, exitPrint2
        addi t1, t1, 1
        jal x0, printString2
    exitPrint2:

    # count negative numbers
    addi a3, x0, -1
    jal x1, countArray
    addi a7, x0, 1
    ecall
    add s5, a0, x0 # save negCnt to s5
    
    #newline
    addi s2, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0x105
    lb a0, 0(s2)
    addi a7, x0, 11
    ecall
    
    #print str3
    addi s2, x0, 0
    addi t1, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0xdc
    addi s3, x0, 17
    addi a7, x0, 11
    printString3:
        add t0, t1, s2
        lb a0, 0(t0)
        ecall
        beq t1, s3, exitPrint3
        addi t1, t1, 1
        jal x0, printString3
    exitPrint3:

    #count zeroes
    addi a3, x0, 0
    jal x1, countArray
    addi a7, x0, 1
    ecall
    add s6, a0, x0 # save zeroCnt to s6
    
    #newline
    addi s2, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0x105
    lb a0, 0(s2)
    addi a7, x0, 11
    ecall
    
    # print str4
    addi s2, x0, 0
    addi t1, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0xee
    addi s3, x0, 22
    addi a7, x0, 11
    printString4:
        add t0, t1, s2
        lb a0, 0(t0)
        ecall
        beq t1, s3, exitPrint4
        addi t1, t1, 1
        jal x0, printString4
    exitPrint4:

    #calculate sum
    jal x1, sumArray
    addi a7, x0, 1
    ecall
    add s7, a0, x0 # save sum to s7
    
    # newline
    addi s2, x0, 0
    lui s2, 0x10000
    addi s2, s2, 0x105
    lb a0, 0(s2)
    addi a7, x0, 11
    ecall
    
    # exit
    jal x0, exit
    
# REQUIRE: a1 holds array address,
#          a2 holds size of array
# EFFECT: return sum of the array in a0
sumArray:
    addi a0, x0, 0
    addi t1, x0, 0
    loopSum:
        bge t1, a2, exitLoopSum
        slli t2, t1, 2
        add t2, t2, a1
        lw t3, 0(t2)
        add a0, a0, t3
        addi t1, t1, 1
        jal x0, loopSum
        
    exitLoopSum:
        jalr x0, x1, 0

# REQUIRE: a1 holds array address,
#          a2 holds size of array,
#          a3 holds counting type
#             (0: zero, 1: positive, -1: negative)
# EFFECT: return number of counts in a0
countArray:
    addi a0, x0, 0
    addi t1, x0, 0
    loopCnt:
        bge t1, a2, exitCountArray

        # load an element from arr
        slli t2, t1, 2
        add t2, t2, a1
        lw t3, 0(t2)

        # create stack
        addi sp, sp, -8
        sw x1, 4(sp)
        sw a0, 0(sp)

        # select counting type
        add a0, x0, t3
        addi t0, x0, 1
        beq a3, t0, checkIfPos
        addi t0, x0, -1
        beq a3, t0, checkIfNeg
        addi t0, x0, 0
        beq a3, t0, checkIfZero

        # judge data
        checkIfPos:
            jal x1, isPos
            jal x0, exitBranch
        checkIfNeg:
            jal x1, isNeg
            jal x0, exitBranch
        checkIfZero:
            jal x1, isZero
            jal x0, exitBranch
        exitBranch:
        beq a0, x0, skipCnt # Skip if not match

        # count
        lw a0, 0(sp) # restore a0 from stack
        addi a0, a0, 1
        addi t1, t1, 1

        # free all stack space
        lw x1, 4(sp)
        addi sp, sp, 8

        jal x0, loopCnt

        skipCnt:
            addi t1, t1, 1

            # free all stack space
            lw a0, 0(sp)
            lw x1, 4(sp)
            addi sp, sp, 8

            jal x0, loopCnt

    # return
    exitCountArray:
        jalr x0, x1, 0

# REQUIRE: a0 holds an int
# EFFECT: if a0 is positive, return 1 in a0, else return 0
isPos:
    bgt a0, x0, isPosTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isPosTrue:
        addi a0, x0, 1
        jalr x0, x1, 0

# REQUIRE: a0 holds an int
# EFFECT: if a0 is negative, return 1 in a0, else return 0
isNeg:
    blt a0, x0, isNegTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isNegTrue:
        addi a0, x0, 1
        jalr x0, x1, 0

# REQUIRE: a0 holds an int
# EFFECT: if a0 equals to 0, return 1 in a0, else return 0    
isZero:
    beq a0, x0, isZeroTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isZeroTrue:
        addi a0, x0, 1
        jalr x0, x1, 0

exit:
    addi a0, x0, 0 # return 0