# RISC-V ISA Practice Devcontainer

Open in WSL then F1 > Open folder in dev container `risc-v`.

from /workspaces/practice/risc-v# make clean && make && make test CONCEPT=load

ctrl+a + x to exit running qemu.

## Process

1. Verilog is implementing the hardware.
1. Assembly is implementing the software.

## One concept at a time

1. Write Assembly Program in concepts/<concept>.s
2. Create minimal verilog model in rtl/<concept>.v
3. Create verilator simulation + test harness in sim/<concept>.c
4. Write emulator tests in tests/<concept>.qemu.sh


## Verify the program works against qemu target

1. Read dissassembly output by `objdump -d build/load-qemu.elf`
2. Read symbol/section output by `readelf -a build/load-qemu.elf`
3. Read memory layout output by `objdump -h build/load-qemu.elf`

## Verify program runs correctly in simulator