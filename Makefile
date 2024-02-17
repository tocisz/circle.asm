ASSEMBLER = z80-unknown-coff-as
LINKER = z80-unknown-coff-ld
OBJCOPY = z80-unknown-coff-objcopy

ASFLAGS = -a -march=z80
LDFLAGS =  

LD_FILES := $(wildcard *.ld)
SRC_ASM := $(wildcard *.asm)
OBJ_FILES := $(patsubst %.asm,%.out,$(SRC_ASM))

all: ram.hex

ram.hex: system.out
	$(OBJCOPY) -O ihex -j.ram $< $@

system.out: $(OBJ_FILES) $(LD_FILES)
	$(LINKER) $(LDFLAGS) -T system.ld -Map=system.map $(OBJ_FILES) -o $@

%.out: %.asm
	$(ASSEMBLER) $(ASFLAGS) $< -o $@ > $<.lst

.PHONY: clean md5check
clean:
	rm -f *.hex *.out *.bin *.map *.lst