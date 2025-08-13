    .section .text.start
    .globl _start

    .equ UART_BASE, 0x10000000
    .equ UART_THR,  0        # transmit holding reg (write)
    .equ UART_LSR,  5        # line status reg (read)
    .equ LSR_THRE,  0x20     # transmitter holding reg empty

_start:
    la   sp, _stack_top        # stack from linker script
    la   t0, message           # t0 -> string

1:  lbu  t1, 0(t0)             # load next char
    beqz t1, 3f                # done at NUL

2:  li   t2, UART_BASE
    lb   t3, UART_LSR(t2)      # poll LSR
    andi t3, t3, LSR_THRE
    beqz t3, 2b                # wait for THR empty
    sb   t1, UART_THR(t2)      # write char

    addi t0, t0, 1
    j    1b

3:  jal  x0, 3b                # loop forever (no OS)

    .section .rodata
message:
    .asciz "hello, world\n"
