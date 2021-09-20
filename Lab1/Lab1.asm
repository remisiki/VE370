.data
str: .string "Hello world!"

.text
    la a1, str
    lui x22, 0x10000
    addi x22, x22, 0x100
    sw a1, 48(x22)
    lw a0, 48(x22)
    li a7, 4
    ecall