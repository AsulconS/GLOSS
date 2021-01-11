# ------------------------------------------------------------------------------
# MAKEFILE DEFINITIONS
# ------------------------------------------------------------------------------

AS=arm-none-eabi-as
LD=arm-none-eabi-ld
CC=arm-none-eabi-gcc
OC=arm-none-eabi-objcopy

CCA=-mno-unaligned-access -c -O2 -Iinclude
SSA=-mfloat-abi=soft -mcpu=cortex-a9 -mfpu=neon-fp16

BUILD_SCRIPT_ARG=--script lds/arm_build.ld -z max-page-size=0x04
START_SYMBOL_ARG=-e _entry -u _entry
LDA=$(BUILD_SCRIPT_ARG) $(START_SYMBOL_ARG)

EXCEPTION_OBJS=_exception.o _startup.o _swi.o
SYSCALL_OBJS=arrsum.o write.o cls.o dpx.o img.o

TARGET=main
OBJS=$(EXCEPTION_OBJS) $(SYSCALL_OBJS) $(TARGET).o

# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# RULES
# ------------------------------------------------------------------------------

all: clean build objcopy trash
notrash: clean build objcopy

build: $(OBJS)
	$(LD) $(LDA) -o build/elf/$(TARGET).elf $(OBJS)

objcopy:
	$(OC) -O binary build/elf/$(TARGET).elf build/bin/$(TARGET).bin

folder:
	@mkdir -p build/bin build/elf

trash:
	@rm -f *.o

clean: folder
	@rm -f *.o build/bin/*.bin build/elf/*.elf

# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# GLOSS CORE
# ------------------------------------------------------------------------------

_exception.o: src/_exception.s
	$(AS) $(SSA) -o _exception.o src/_exception.s

_swi.o: src/_swi.s
	$(AS) $(SSA) -o _swi.o src/_swi.s

_startup.o: src/_startup.s
	$(AS) $(SSA) -o _startup.o src/_startup.s

arrsum.o: src/sys/arrsum.s
	$(AS) $(SSA) -o arrsum.o src/sys/arrsum.s

write.o: src/sys/write.s
	$(AS) $(SSA) -o write.o src/sys/write.s

cls.o: src/sys/cls.s
	$(AS) $(SSA) -o cls.o src/sys/cls.s

dpx.o: src/sys/dpx.s
	$(AS) $(SSA) -o dpx.o src/sys/dpx.s

img.o: src/sys/img.c
	$(CC) $(CCA) $(SSA) -o img.o src/sys/img.c

# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# TARGET
# ------------------------------------------------------------------------------

$(TARGET).o: src/$(TARGET).s
	$(AS) $(OBJ_ARGS) -o $(TARGET).o src/$(TARGET).s

# ------------------------------------------------------------------------------
