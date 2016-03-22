DISTDIR := build/boot

all: bootfloppy

bootfloppy: $(DISTDIR)/bootfloppy.img

bootup: $(DISTDIR)/bootfloppy.img
	qemu-system-i386 -fda $(DISTDIR)/bootfloppy.img -boot a

$(DISTDIR):
	mkdir -p $(DISTDIR)

$(DISTDIR)/%.bin: %.asm | $(DISTDIR)
	nasm -f bin $< -o $@

$(DISTDIR)/%.img: $(DISTDIR)/%.bin | $(DISTDIR)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$< of=$@ conv=notrunc

clean:
	rm -vrf $(DISTDIR)
