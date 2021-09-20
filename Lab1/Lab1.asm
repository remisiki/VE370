.data
str: .string "Hello world!"

.text
    la a1, str

    # Set the address in x22 as 0x10000100
    lui x22, 0x10000
    addi x22, x22, 0x100

    # Store str in x22
    sw a1, 48(x22)

    # Print str
    lw a0, 48(x22)
    li a7, 4
    ecall