.data
str: .string "Hello world!"

.text
    lui a1, 0x10000

    # Set target address
    lui s0, 0x10000
    addi s0, s0, 0x100

    # Length of string
    li a2 12

    # Store str to the new address
Loop:
    add s2, a3, a1    # original address
    lw t0, 0(s2)    # load one char from original str
    add s2, a3, s0    # target address
    sw t0, 0(s2)    # save to target address
    beq a3, a2, EndLoop    # reach end of str
    addi a3, a3, 1    # next char
    beq x0, x0, Loop    # loop
EndLoop:
    li a3, 0    # reset the counter to 0

    # Print str in the new address

    li a7, 11    # set system call to char mode
Print:
    add s2, s0, a3
    lw a0, 0(s2)
    ecall
    beq a3, a2, Exit
    addi a3, a3, 1
    beq x0, x0, Print
    
Exit:
    nop
