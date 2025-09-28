CONCEPT ?= load

# Build System
BUILD 	:= build
$(BUILD):
	mkdir -p $@

# RISC-V Toolchain
RISCV 	:= riscv64-unknown-elf
GCC  	:= $(RISCV)-gcc
OBJDUMP := $(RISCV)-objdump
OBJCOPY := $(RISCV)-objcopy

# =============================================================================
# STEP 1-3: Input Files (The Three Components)
# =============================================================================
ASM := concepts/$(CONCEPT).s      # 1. RISC-V assembly program
RTL := rtl/$(CONCEPT).v           # 2. Verilog hardware model
SIM := tests/$(CONCEPT).sim.cpp     # 3. Verilator test harness

# Intermediate files
OBJ := $(BUILD)/$(CONCEPT).o
PCF := constraints/$(CONCEPT).pcf

# Output binaries
ELF_SIM     := $(BUILD)/$(CONCEPT)-sim.elf     # For simulation
ELF_QEMU    := $(BUILD)/$(CONCEPT)-qemu.elf    # For QEMU

# =============================================================================
# STEP 4: SIMULATION - Validate Your Hardware Understanding  
# =============================================================================

# Compilation settings
COMPILE_FLAGS := -march=rv32i -mabi=ilp32 -nostartfiles -nostdlib -g -O0
LINK_FLAGS := -Wl,--build-id=none -Wl,-Map,$(BUILD)/$(CONCEPT).map

# Build object file from assembly
$(OBJ): $(ASM) | $(BUILD)
	@echo "🔧 Compiling assembly: $(ASM)"
	$(GCC) -c $(COMPILE_FLAGS) -o $@ $<

# Build ELF for simulation (using simulation memory layout)
$(ELF_SIM): $(OBJ) linker_sim.ld
	@echo "🔗 Linking for simulation: $(ELF_SIM)"
	$(GCC) $(COMPILE_FLAGS) $(LINK_FLAGS) -T linker_sim.ld -o $@ $(OBJ)

# Verilator simulation
VERILATOR ?= verilator
SIM_EXE := $(BUILD)/$(CONCEPT)-sim

.PHONY: sim
sim: $(ELF_SIM) | $(BUILD)
	@echo "🎯 STEP 4: Running hardware simulation for concept '$(CONCEPT)'"
	@echo "   Testing: $(RTL) with $(SIM)"
	verilator -cc $(RTL) --exe $(SIM) \
		-CFLAGS "-O2 -std=c++17" -o $(notdir $(SIM_EXE))
	$(MAKE) -C obj_dir -f V$(CONCEPT).mk
	cp obj_dir/$(notdir $(SIM_EXE)) $(SIM_EXE)
	@echo "   Simulation results:"
	$(SIM_EXE)

# =============================================================================
# STEP 5: QEMU CROSS-VALIDATION - Golden Reference
# =============================================================================

# Build ELF for QEMU (using virtual machine memory layout)
$(ELF_QEMU): $(OBJ) linker_virt.ld
	@echo "🔗 Linking for QEMU: $(ELF_QEMU)"
	$(GCC) $(COMPILE_FLAGS) $(LINK_FLAGS) -T linker_virt.ld -o $@ $(OBJ)

# QEMU execution
QEMU 		?= qemu-system-riscv32
QEMU_FLAGS  ?= -machine virt -nographic -bios none

.PHONY: qemu
qemu: $(ELF_QEMU)
	@echo "🎯 STEP 5: Running QEMU cross-validation for concept '$(CONCEPT)'"
	@echo "   Executing: $(ASM) on golden reference RISC-V"
	$(QEMU) $(QEMU_FLAGS) -kernel $<

# =============================================================================
# STEP 6: COMPARATIVE TESTING - Verify Sim vs QEMU Match
# =============================================================================

.PHONY: test
test:
	@echo "🎯 STEP 6: Comparing simulation vs QEMU results for concept '$(CONCEPT)'"
	@echo "   Running both targets and validating they produce identical results..."
	./scripts/build-and-test.sh $(CONCEPT)

# =============================================================================
# STEP 7: FPGA DEPLOYMENT - Real Hardware
# =============================================================================

.PHONY: fpga
fpga: fpga-program
	@echo "🎯 STEP 7: Successfully deployed concept '$(CONCEPT)' to FPGA hardware!"

# =============================================================================
# UTILITY TARGETS
# =============================================================================

# Disassembly for debugging
.PHONY: disasm
disasm: $(ELF_QEMU) $(ELF_SIM)
	@echo "📋 Generating disassembly for concept '$(CONCEPT)'"
	$(OBJDUMP) -D -M no-aliases,numeric $(word 1,$^) > $(BUILD)/$(CONCEPT).qemu.dis
	$(OBJDUMP) -D -M no-aliases,numeric $(word 2,$^) > $(BUILD)/$(CONCEPT).sim.dis
	@echo "   Disassembly: $(BUILD)/$(CONCEPT).qemu.dis"
	@echo "   Disassembly: $(BUILD)/$(CONCEPT).sim.dis"

# Direct QEMU execution (alternative to qemu target)
.PHONY: run-qemu
run-qemu: $(ELF_QEMU)
	@echo "🚀 Direct QEMU execution (alternative to 'make qemu')"
	$(QEMU) $(QEMU_FLAGS) -kernel $<

# ---- FPGA synthesis ----
FPGA_BUILD_DIR := build/fpga

.PHONY: fpga-build
fpga-build: | $(BUILD)
	@echo "Building FPGA bitstream for $(CONCEPT)..."
	./scripts/fpga-build.sh $(CONCEPT)

.PHONY: fpga-program  
fpga-program: fpga-build
	@echo "Programming FPGA with $(CONCEPT)..."
	./scripts/fpga-program.sh $(CONCEPT)

.PHONY: fpga-clean
fpga-clean:
	rm -rf $(FPGA_BUILD_DIR)

.PHONY: fpga-test
fpga-test: fpga-program
	@echo "🎯 Manual test instructions:"
	@echo "1. Press the user button (PIN 10) on ICEBreaker"
	@echo "2. Watch the green LED (PIN 37) - it should follow the button state"
	@echo "3. Button pressed = LED on, Button released = LED off"

# Update clean target
# Update clean target
clean:
	rm -rf $(BUILD) obj_dir *.vcd $(FPGA_BUILD_DIR)

# =============================================================================
# COMPLETE WORKFLOW EXAMPLE
# =============================================================================
# To learn a new RISC-V concept (e.g., "load" instruction):
#
# 1. Create concepts/load.s        - Write RISC-V assembly
# 2. Create rtl/load.v             - Model the hardware behavior  
# 3. Create tests/load.sim.cpp       - Write simulation test harness
# 4. Create tests/load.qemu.sh     - Write QEMU validation test (optional)
# 5. make CONCEPT=load sim         - Validate hardware model
# 6. make CONCEPT=load qemu        - Test on reference implementation
# 7. make CONCEPT=load test        - Cross-validate both targets
# 8. make CONCEPT=load fpga        - Deploy to real hardware
# =============================================================================