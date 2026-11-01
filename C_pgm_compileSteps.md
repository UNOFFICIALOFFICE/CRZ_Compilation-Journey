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


## 4️⃣ Inspect symbol table in .o
Shows symbols and their types; unresolved symbols are marked as U.
```
arm-none-eabi-nm main.o
```


## 5️⃣ Disassemble object file (.o)
Shows machine instructions with symbolic (unfixed) addresses.
```
arm-none-eabi-objdump -d main.o
```

## 6️⃣ Linking (.o → .elf)
Combines object files, resolves symbols, assigns real FLASH/RAM addresses using linker script.
```
arm-none-eabi-gcc \
  -mcpu=cortex-m3 -mthumb \
  -T linker.ld \
  -nostdlib \
  main.o add.o \
  -o main.elf
```

## 7️⃣ Inspect symbol table in .elf
Shows symbols with final absolute addresses.
```
arm-none-eabi-nm main.elf
```

## 8️⃣ Disassemble ELF
Shows final executable instructions with resolved addresses.
```
arm-none-eabi-objdump -d main.elf
```

## 9️⃣ Convert ELF → HEX
Creates address-aware ASCII file for flashing tools.
```
arm-none-eabi-objcopy -O ihex main.elf main.hex
```

## 🔟 Convert ELF → BIN
Creates raw binary image (pure bytes, no metadata).
```
arm-none-eabi-objcopy -O binary main.elf main.bin
```

## 1️⃣1️⃣ Hexdump the BIN file
Displays the exact bytes that will be written into FLASH.
```
hexdump -C main.bin
```