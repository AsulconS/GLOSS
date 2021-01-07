AS=arm-none-eabi-as
LD=arm-none-eabi-ld
OC=arm-none-eabi-objcopy

SPECS_ARGS=-mfloat-abi=soft -march=armv7-a -mcpu=cortex-a9 -mfpu=neon-fp16
DEBUG_FLAG=--gdwarf2

OBJ_ARGS=$(SPECS_ARGS)

BUILD_SCRIPT_ARG=--script lds/arm_build.ld -z max-page-size=0x04
START_SYMBOL_ARG=-e _entry -u _entry

TARGET=main

EXCEPTION_OBJS=_startup.o _undef.o _swi.o

OBJS=_exception.o $(EXCEPTION_OBJS) $(TARGET).o arrsum.o

all: clean build objcopy trash

build: $(OBJS)
	$(LD) $(BUILD_SCRIPT_ARG) $(START_SYMBOL_ARG) -o build/elf/$(TARGET).elf $(OBJS)

objcopy:
	$(OC) -O binary build/elf/$(TARGET).elf build/bin/$(TARGET).bin

_exception.o: src/_exception.s
	$(AS) $(OBJ_ARGS) -o _exception.o src/_exception.s

_undef.o: src/_undef.s
	$(AS) $(OBJ_ARGS) -o _undef.o src/_undef.s

_swi.o: src/_swi.s
	$(AS) $(OBJ_ARGS) -o _swi.o src/_swi.s

_startup.o: src/_startup.s
	$(AS) $(OBJ_ARGS) -o _startup.o src/_startup.s

$(TARGET).o: src/$(TARGET).s
	$(AS) $(OBJ_ARGS) -o $(TARGET).o src/$(TARGET).s

arrsum.o: old/arrsum.s
	$(AS) $(OBJ_ARGS) -o arrsum.o old/arrsum.s

folder:
	@mkdir -p build/bin build/elf

trash:
	@rm -f *.o

clean: folder
	@rm -f *.o build/bin/*.bin build/elf/*.elf
