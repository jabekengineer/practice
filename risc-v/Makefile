# Toolchain
CC  := riscv64-unknown-elf-gcc
OBJDUMP := riscv64-unknown-elf-objdump

# ISA/ABI
MARCH := rv32i
MABI  := ilp32

# Layout
SRCS  := $(wildcard concepts/*.s)
NAMES := $(basename $(notdir $(SRCS)))
BUILDDIR := build

ELFS := $(addprefix $(BUILDDIR)/,$(addsuffix .elf,$(NAMES)))
OBJS := $(addprefix $(BUILDDIR)/,$(addsuffix .o,$(NAMES)))
DISS := $(addprefix $(BUILDDIR)/,$(addsuffix .dis,$(NAMES)))

.PHONY: all clean run dis test

all: $(ELFS) $(DISS)

$(BUILDDIR):
	@mkdir -p $@

# Assemble each concepts/<name>.s to build/<name>.o
$(BUILDDIR)/%.o: concepts/%.s | $(BUILDDIR)
	$(CC) -c -march=$(MARCH) -mabi=$(MABI) -nostdlib -o $@ $<

# Link to ELF using our bare‑metal linker script
$(BUILDDIR)/%.elf: $(BUILDDIR)/%.o linker.ld
	$(CC) -nostartfiles -nostdlib -march=$(MARCH) -mabi=$(MABI) \
	      -T linker.ld -Wl,--build-id=none -o $@ $<

# Disassembly for inspection
$(BUILDDIR)/%.dis: $(BUILDDIR)/%.elf
	$(OBJDUMP) -D -M no-aliases,numeric $< > $@

# Run one concept: make run NAME=hello
run: $(BUILDDIR)/$(NAME).elf
	qemu-system-riscv32 -machine virt -nographic -bios none \
	    -kernel $(BUILDDIR)/$(NAME).elf

dis: $(DISS)

clean:
	rm -rf $(BUILDDIR)
