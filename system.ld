OUTPUT_FORMAT("coff-z80")

INCLUDE memory.ld

SECTIONS
{
    .ram : {
        *(.text .data .bss)
    } > ram
}
