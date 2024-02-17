OUTPUT_FORMAT("coff-z80")

INCLUDE memory.ld

SECTIONS
{
    BASE = 0x9000;
    .reserved : {
        . = ABSOLUTE(BASE);
    } > ram
    .ram : {
        *(.text .data .bss)
    } > ram
}
