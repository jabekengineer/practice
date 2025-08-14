ENTRY(_start)

MEMORY { RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M }

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
