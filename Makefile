clean:
	rm -rf *.elf *.o *.i *.bin *.hex *.s main

b:
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -c main.c
	arm-none-eabi-objdump -h main.o