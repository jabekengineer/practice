ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
  . = ORIGIN(RAM);

  .text : ALIGN(4)
  {
    KEEP(*(.text.start))   /* place reset/entry first */
    *(.text*)
  } > RAM

  .rodata : ALIGN(4) { *(.rodata*) } > RAM
  .data   : ALIGN(4) { *(.data*)   } > RAM

  .bss (NOLOAD) : ALIGN(4)
  {
    *(.bss*) *(COMMON)
  } > RAM

  /* Simple stack near the top of our RAM region */
  . = ORIGIN(RAM) + LENGTH(RAM);
  . = ALIGN(16);
  _stack_top = .;
}
