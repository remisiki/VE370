.data
str: .string "Hello world!"

.text
    la a1, str
    # lui a1, 0x10000
    # lw a2, 48(a1)

    # Set the address in x22 as 0x10000100
    lui s0, 0x10000
    addi s0, s0, 0x100

    addi a2, a2, 12
    # sw a1, 48(s0)

    # Store str in x22
Loop:
    add s2, a3, a1
    add s3, a3, s0
    lw t0, 0(s2)
    sw t0, 0(s3)
    beq a3, a2, EndLoop
    addi a3, a3, 1
    beq x0, x0, Loop
EndLoop:
    li a3, 0

    # Print str

    li a7, 11
Print:
    add s2, s0, a3
    lw a0, 0(s2)
    ecall
    beq a3, a2, Exit
    addi a3, a3, 1
    beq x0, x0, Print
    
Exit:
    nop
