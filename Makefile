#Toolchain
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
BIN = arm-none-eabi-objcopy
STL = st-flash
CPPCHECK=cppcheck


#Files
SOURCES=main.c

#Flags
CFLAGS = -mthumb -mcpu=cortex-m3
WFLAGS=-Wall -Wextra -Werror -Wshadow

#Directories
INCLUDE_DIRS=/projecttest/CICDPipeline/Capnography


#Phonies
.PHONY: all clean flash erase cppcheck

all: app.bin

crt.o: crt.s
	$(AS) -o crt.o crt.s

main.o: main.c
	$(CC) $(CFLAGS) -I $(INCLUDE_DIRS) -c -o main.o main.c

app.elf: linker.ld crt.o main.o
	$(LD) -T linker.ld -o app.elf crt.o main.o

app.bin: app.elf
	$(BIN) -O binary app.elf app.bin

clean:
	rm -f *.o *.elf *.bin

flash: app.bin
	$(STL) write app.bin 0x8000000

erase:
	$(STL) erase
cppcheck:
	@$(CPPCHECK) $(SOURCES)
#	@$(CPPCHECK) --quiet --enable=all --error-exitcode=1  --force --check-config \
#	--inline-suppr  \
#	-I $(INCLUDE_DIRS)  \
#	$(SOURCES)
		
		#
