# Three-target Concept-by-concept RISC-V learning
1. concepts/concept.s - RISC-V assembly program
2. rtl/concept.v - Verilog hardware model
3. tests/concept.sim.c - Verilator sim test harness
4. tests/concept.qemu.sh - Qemu emulation test harness

`make CONCEPT=concept sim` to confirm that you understand the instruction and are testing it right.
4. Cross-validate in QEMU - link assembly and run ELF on "golden reference" implementation of RISC-V ISA on a simulated RISC-V processor. 
`make CONCEPT=concept run-qemu`. This runs it an exposes gdb behavior.
`ctrl+a, c --(qemu)> quit` to use qemu monitor then quit the guestOS.
5. Run sim and qemu to verify that they match.
`make CONCEPT=concept test`
6. Deploy to FPGA
`make CONCEPT=concept fpga`
a. You need to configure the USB passthrough from Windows Host to WSL to dev container.
In powershell as admin: `usbipd list` (uses usbipd)[https://github.com/dorssel/usbipd-win]
- make the device shared
- `usbipd attach --wsl --busid <BUSID>`

In WSL, `lsusb` and verify that:
Bus 001 Device 003: ID 0403:6010 Future Technology Devices International, Ltd FT2232C/D/H Dual UART/FIFO IC
shows up

In devcontainer, double check with scripts/check-usb.sh


### LED Control
pin 11 - green LED is active-low 
drive 0 → LED ON
drive 1 → LED OFF


