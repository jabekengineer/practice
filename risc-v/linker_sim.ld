ENTRY(_start)

MEMORY { RAM (wx) : ORIGIN = 0x00000000, LENGTH = 64K }

SECTIONS {
  . = ORIGIN(RAM);

  .text : {
    *(.text._start)
    *(.text*)
  } > RAM

  .rodata : { *(.rodata*) } > RAM
  .data :   { *(.data*) }   > RAM
  .bss  :   { *(.bss*) *(COMMON) } > RAM

  PROVIDE(__ram_base = ORIGIN(RAM));
  /DISCARD/ : { *(.comment*) *(.note*) }
}
