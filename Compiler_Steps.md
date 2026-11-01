# 🔁 C → Binary: Complete Command Flow (ARM, Linux)

## 1️⃣ Preprocessing (.c → .i)
Expands #include, #define, removes comments, handles conditional compilation (pure text processing).
```
arm-none-eabi-gcc -E main.c > main.i
```

## 2️⃣ Compilation (.i/.c → .s)
Converts C code into ARM Thumb assembly (CPU instructions, no addresses).
```
arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -S main.c
```

## 3️⃣ Assembling (.s → .o)
Converts assembly into machine code + symbols + relocation info (still no final addresses).
```
arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -c main.s
```
(or directly)
```
arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -c main.c
```

## 4️⃣ Inspect object file sections (.o)
Shows sections like .text, .data, .bss inside the relocatable object file.
```
arm-none-eabi-objdump -h main.o
```

## 5️⃣ Inspect symbol table in .o
Shows symbols and their types; unresolved symbols are marked as U.
```
arm-none-eabi-nm main.o
```

## 6️⃣ Inspect relocation entries in .o
Shows where the linker must patch addresses (e.g., function calls).
```
arm-none-eabi-objdump -r main.o
```

## 7️⃣ Disassemble object file (.o)
Shows machine instructions with symbolic (unfixed) addresses.
```
arm-none-eabi-objdump -d main.o
```

## 8️⃣ Linking (.o → .elf)
Combines object files, resolves symbols, assigns real FLASH/RAM addresses using linker script.
```
arm-none-eabi-gcc \
  -mcpu=cortex-m3 -mthumb \
  -T linker.ld \
  -nostdlib \
  main.o \
  -o main.elf
```

## 9️⃣ Inspect ELF sections
Shows final memory placement of sections (FLASH/RAM addresses).
```
arm-none-eabi-objdump -h main.elf
```

## 🔟 Inspect symbol table in .elf
Shows symbols with final absolute addresses.
```
arm-none-eabi-nm main.elf
```

## 1️⃣1️⃣ Disassemble ELF
Shows final executable instructions with resolved addresses.
```
arm-none-eabi-objdump -d main.elf
```

## 1️⃣2️⃣ Convert ELF → HEX
Creates address-aware ASCII file for flashing tools.
```
arm-none-eabi-objcopy -O ihex main.elf main.hex
```

## 1️⃣3️⃣ Convert ELF → BIN
Creates raw binary image (pure bytes, no metadata).
```
arm-none-eabi-objcopy -O binary main.elf main.bin
```

## 1️⃣4️⃣ Hexdump the BIN file
Displays the exact bytes that will be written into FLASH.
```
hexdump -C main.bin
xxd -b main.bin
```
--- 
---

[Link to 16-bit Thumb instruction encoding ](https://developer.arm.com/documentation/ddi0403/d/Application-Level-Architecture/The-Thumb-Instruction-Set-Encoding/16-bit-Thumb-instruction-encoding?lang=en)