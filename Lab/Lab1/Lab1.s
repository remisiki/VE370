.data
str: .string "Hello world!"

.text
    lui s0, 0x10000

    # Set target address
    lui s3, 0x10000
    addi s3, s3, 0x100

    # Length of string
    addi s1, s1, 12

    # Store str to the new address
Loop:
    add s4, s2, s0    # original address
    lb t0, 0(s4)    # load one char from original str
    add s4, s2, s3    # target address
    sb t0, 0(s4)    # save to target address
    beq s2, s1, EndLoop    # reach end of str
    addi s2, s2, 1    # next char
    beq x0, x0, Loop    # loop
EndLoop:
    add s2, x0, x0    # reset the counter to 0

    # Print str in the new address

    addi a7, a7, 11    # set system call to char mode
Print:
    add s4, s3, s2
    lb a0, 0(s4)
    ecall
    beq s2, s1, Exit
    addi s2, s2, 1
    beq x0, x0, Print
    
Exit:
    add a0, a0, x0
