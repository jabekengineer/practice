# build and run one concept at a time.
CONCEPT 	?= load

# Build System
BUILD 	:= build
RISCV 	?= riscv64-unknown-elf
GCC  	:= $(RISCV)-gcc
OBJDUMP := $(RISCV)-objdump
OBJCOPY := $(RISCV)-objcopy

# inputs
ASM := concepts/$(CONCEPT).s
OBJ := $(BUILD)/$(CONCEPT).o
SIM := sim/$(CONCEPT).c
RTL := rtl/$(CONCEPT).v

# outputs
ELF_QEMU    := $(BUILD)/$(CONCEPT)-qemu.elf
ELF_SIM     := $(BUILD)/$(CONCEPT)-sim.elf

# QEMU run
QEMU 		?= qemu-system-riscv32
QEMU_FLAGS  ?= -machine virt -nographic -bios none

# Create build directory
$(BUILD):
	mkdir -p $@

.PHONY: all
all: $(ELF_QEMU) disasm

COMPILE_FLAGS := -march=rv32i -mabi=ilp32 -nostartfiles -nostdlib -g -O0
$(OBJ): $(ASM) | $(BUILD)
	$(GCC) -c $(COMPILE_FLAGS) -o $@ $<

LINK_FLAGS := -Wl,--build-id=none -Wl,-Map,$(BUILD)/$(CONCEPT).map

$(ELF_QEMU): $(OBJ) linker_virt.ld
	$(GCC) $(COMPILE_FLAGS) $(LINK_FLAGS) -T linker_virt.ld -o $@ $(OBJ)

$(ELF_SIM): $(OBJ) linker_sim.ld
	$(GCC) $(COMPILE_FLAGS) $(LINK_FLAGS) -T linker_sim.ld  -o $@ $(OBJ)

# ---- disassembly (of QEMU ELF) ----
.PHONY: disasm
disasm: $(ELF_QEMU)
	$(OBJDUMP) -d -M no-aliases,numeric $< > $(BUILD)/$(CONCEPT).qemu.dis
	@echo "QEMU Disassembly: $(BUILD)/$(CONCEPT).qemu.dis"

# ---- run in QEMU ----
.PHONY: run-qemu
run-qemu: $(ELF_QEMU)
	$(QEMU) $(QEMU_FLAGS) -kernel $<

# ---- verilator sim ----
VERILATOR ?= verilator
SIM_EXE := $(BUILD)/$(CONCEPT)-sim

.PHONY: sim
sim: $(ELF_SIM) | $(BUILD)
	verilator -cc $(RTL) --exe $(SIM) \
		-CFLAGS "-O2 -std=c++17" -o $(notdir $(SIM_EXE))
	$(MAKE) -C obj_dir -f V$(CONCEPT).mk
	cp obj_dir/$(notdir $(SIM_EXE)) $(SIM_EXE)
	$(SIM_EXE)

# ---- convenience: run both under test script ----
.PHONY: test
test:
	./scripts/build-and-test.sh $(CONCEPT)

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
clean:
	rm -rf $(BUILD) obj_dir *.vcd $(FPGA_BUILD_DIR)

one := 1
two := 2 $(one)
two += $(two)
toy:
	echo $(two)