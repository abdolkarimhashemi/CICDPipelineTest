#test
#Directoriess
TOOLS_PATH=/home/ubuntu/dev/tools
#TOOLS_PATH=/dev/tools
TOOLS_DIR=${TOOLS_PATH}
STM32GCC_ROOT_DIR=$(TOOLS_DIR)/stm32gcc/bin#arm-none-eabi#arm-gnu-toolchain-13.2rel1
STM32GCC_BIN_DIR=$(STM32GCC_ROOT_DIR)/bin
STM32GCC_INCLUDE_DIR=$(TOOLS_PATH)/Capnography#$(STM32GCC_ROOT_DIR)/include
BUILD_DIR=build
OBJ_DIR=$(BUILD_DIR)/obj
BIN_DIR=$(BUILD_DIR)/bin
TI_CCS_DIR=$(TOOLS_DIR)/ccs1110/ccs
DEBUG_BIN_DIR=$(TI_CCS_DIR)/ccs_base/DebugServer/bin
DEBUG_DRIVERS_DIR=$(TOOLS_DIR)/ccs_base/DebugServer/drivers

LIB_DIRS=$(STM32GCC_INCLUDE_DIR)
INCLUDE_DIRS=$(STM32GCC_INCLUDE_DIR)#\
#	     ./src \
#	     ./external/ \
#	     ./external/printf
##
#Toolchain
CC = $(STM32GCC_ROOT_DIR)/arm-none-eabi-gcc
AS = $(STM32GCC_ROOT_DIR)/arm-none-eabi-as
LD = $(STM32GCC_ROOT_DIR)/arm-none-eabi-ld
BIN = $(STM32GCC_ROOT_DIR)/arm-none-eabi-objcopy
STL = st-flash
CPPCHECK=cppcheck

#
#Files
SOURCES=main.c

#Flags
CFLAGS = -mthumb -mcpu=cortex-m3
WFLAGS=-Wall -Wextra -Werror -Wshadow

#Directories
#INCLUDE_DIRS=/projecttest/CICDPipeline/Capnography


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
