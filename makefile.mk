CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash
CFLAGS = -mthumb -mcpu=cortex-m3
#test:
#	$(info ************  TEST VERSION ************)
all: app.bin
#test:
#	$(info ************  TEST VERSION ************)
crt.o: crt.s
	$(AS) -o crt.o crt.s
test:
	$(info ************  TEST VERSION AS ************)
main.o: main.c
	$(CC) $(CFLAGS) -I /projecttest/projembedded/Capnography -c -o main.o main.c
#test3:
#	$(info ************  TEST VERSION CC ************)
app.elf: linker.ld crt.o main.o
	$(LD) -T linker.ld -o app.elf crt.o main.o
#test4:
#	$(info ************  TEST VERSION LD************)
app.bin: app.elf
	$(BIN) -O binary app.elf app.bin
#test5:
#	$(info ************  TEST VERSION BIN************)
clean:
	rm -f *.o *.elf *.bin
#test6:
#	$(info ************  TEST VERSION RM************)
flash: app.bin
	$(STL) write app.bin 0x8000000
#test7:
#	$(info ************  TEST VERSION STL************)
erase:
	$(STL) erase
#test8:
#	$(info ************  TEST VERSION ER************)
