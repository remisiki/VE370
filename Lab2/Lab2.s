.data
arr: .word -12, -25, 0, 27, 3, -14, 48, 44, -13, 34, 8, -39, 46, -46, -8, 18, 41, -9, -40, -18, -45, -16, -10, -50, -30, -18, -37, -4, 2, 7, 20, 26

.text
main:
    addi s0, x0, 32
    lui s1, 0x10000
    add a1, x0, s1
    add a2, x0, s0
    addi a3, x0, 1
    jal x1, countArray
    addi a7, x0, 1
    ecall
    addi a3, x0, -1
    jal x1, countArray
    addi a7, x0, 1
    ecall
    addi a3, x0, 0
    jal x1, countArray
    addi a7, x0, 1
    ecall
    jal x1, sumArray
    addi a7, x0, 1
    ecall
    jal x0, exit
    
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

countArray:
    addi a0, x0, 0
    addi t1, x0, 0
    loopCnt:
        bge t1, a2, exitCountArray
        slli t2, t1, 2
        add t2, t2, a1
        lw t3, 0(t2)
        addi sp, sp, -8
        sw x1, 4(sp)
        sw a0, 0(sp)
        add a0, x0, t3
        addi t0, x0, 1
        beq a3, t0, checkIfPos
        addi t0, x0, -1
        beq a3, t0, checkIfNeg
        addi t0, x0, 0
        beq a3, t0, checkIfZero
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
        beq a0, x0, skipCnt
        lw a0, 0(sp)
        addi a0, a0, 1
        addi t1, t1, 1
        lw x1, 4(sp)
        addi sp, sp, 8
        jal x0, loopCnt
        skipCnt:
        addi t1, t1, 1
        lw a0, 0(sp)
        lw x1, 4(sp)
        addi sp, sp, 8
        jal x0, loopCnt
    exitCountArray:
        jalr x0, x1, 0

isPos:
    bgt a0, x0, isPosTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isPosTrue:
        addi a0, x0, 1
        jalr x0, x1, 0

isNeg:
    blt a0, x0, isNegTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isNegTrue:
        addi a0, x0, 1
        jalr x0, x1, 0
        
isZero:
    beq a0, x0, isZeroTrue
    addi a0, x0, 0
    jalr x0, x1, 0
    isZeroTrue:
        addi a0, x0, 1
        jalr x0, x1, 0

exit:
    addi a0, x0, 0
    addi x0, x0, 0