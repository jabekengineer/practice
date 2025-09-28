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



