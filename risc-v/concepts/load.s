    .section .text
    .global _start

_start:
    li      x31, 1337
    # Use the RAM base provided by the linker
    la      t0, __ram_base
    sw      x31, 0(t0)
    lw      x7,  0(t0)

    j .