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
    addi t0, x0, 1
    beq a3, t0, posCnt
    jal x0, elseCheckNeg
    elseCheckNeg:
        addi t0, x0, -1
        beq a3, t0, negCnt
        jal x0, elseCheckZero
    elseCheckZero:
        add t0, x0, x0
        beq a3, t0, zeroCnt
        jal x0, exitCountArray
    posCnt:
        addi a0, x0, 0
        addi t1, x0, 0
        loopPosCnt:
            bge t1, a2, exitLoopPosCnt
            slli t2, t1, 2
            add t2, t2, a1
            lw t3, 0(t2)
            ble t3, x0, skipPosCnt
            addi a0, a0, 1
            skipPosCnt:
            addi t1, t1, 1
            jal x0, loopPosCnt
            
        exitLoopPosCnt:
            jal x0, exitCountArray
    negCnt:
        addi a0, x0, 0
        addi t1, x0, 0
        loopNegCnt:
            bge t1, a2, exitLoopPosCnt
            slli t2, t1, 2
            add t2, t2, a1
            lw t3, 0(t2)
            bge t3, x0, skipNegCnt
            addi a0, a0, 1
            skipNegCnt:
            addi t1, t1, 1
            jal x0, loopNegCnt
            
        exitLoopNegCnt:
            jal x0, exitCountArray
    zeroCnt:
        addi a0, x0, 0
        addi t1, x0, 0
        loopZeroCnt:
            bge t1, a2, exitLoopZeroCnt
            slli t2, t1, 2
            add t2, t2, a1
            lw t3, 0(t2)
            bne t3, x0, skipZeroCnt
            addi a0, a0, 1
            skipZeroCnt:
            addi t1, t1, 1
            jal x0, loopZeroCnt
            
        exitLoopZeroCnt:
            jal x0, exitCountArray
    exitCountArray:
        jalr x0, x1, 0
 
exit:
    addi x0, x0, 0