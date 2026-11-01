MEMORY
{
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
    FLASH (xr): ORIGIN = 0x08000000, LENGTH = 1024K
}

_estack = ORIGIN(RAM) + LENGTH (RAM);

_heap_start = _ebss;

SECTIONS
{
    .CODE :
    {
        *(.isr_vector)
        *(.text)
        *(.rodata)
        *(.after_vectors .after_vectors.*)
        . = ALIGN(4);
        _etext = .;
    }>FLASH

    .DATA :
    {
        . = ALIGN(4);
        _sfdata = LOADADDR(.DATA);
        _sdata = .;
        *(.data)
        . = ALIGN(4);
        _edata = .;
    }>RAM AT> FLASH

    .bss :
    {
        . = ALIGN(4);
        _sbss = .;
        *(.bss)
        . = ALIGN(4);
        _ebss = .;
    }>RAM
}