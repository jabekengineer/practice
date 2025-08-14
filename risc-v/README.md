# RISC-V ISA Practice Devcontainer

Open in WSL then F1 > Open folder in dev container `risc-v`.

from /workspaces/practice/risc-v# make clean && make && make run NAME=hello

ctrl+a + x to exit running qemu.

## Process

1. Verilog is implementing the hardware.
1. Assembly is implementing the software.

## One concept at a time

1. Write Assembly Program in concepts/<concept>.s
2. Create minimal verilog model in rtl/<concept>.v
3. Create verilator simulation + test harness in sim/<concept>.c
4. Write emulator tests in tests/<concept>.qemu.sh
5. Pass concept name to builder/runner `/workspaces/practice/risc-v/scripts/build-and-test.sh load`

## Debug tools

1. Read dissassembly output by `objdump -d build/load-qemu.elf`
2. Read symbol/section output by `readelf -a build/load-qemu.elf`
3. Read memory layout output by `objdump -h build/load-qemu.elf`
