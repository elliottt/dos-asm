
CC := i586-pc-msdosdjgpp-gcc
LD := i586-pc-msdosdjgpp-ld

test.exe: main.o screen.o libgcc.a
	$(CC) -o $@ main.o screen.o -L .

LIBGCC_A := $(shell find $(DJGPP) -name libgcc.a)

# This is gross, but nix ships a stripped libgcc.a for djgpp, which it then
# fails to link. To work around this:
# 1. copy libgcc.a into this directory
# 2. run ranlib on it to re-create the index
# 3. add `-L .` when linking, to use this libgcc.a when processing -lgcc
libgcc.a: $(LIBGCC_A)
	cp $< $@
	chmod 644 $@
	i586-pc-msdosdjgpp-ranlib $@

screen.o: screen.asm
	nasm -fcoff -o $@ $<

clean:
	$(RM) *.exe
	$(RM) *.a
	$(RM) *.o
