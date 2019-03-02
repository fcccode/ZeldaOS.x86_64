DIRS = kernel

IMAGE = Zelda64.img

include mk/kernel64.mk
include mk/bootloader64.mk

.PHONY:clean
clean: KERNEL_CLEAN BOOTLOADER_CLEAN
	@rm -f $(IMAGE)

.PHONY:image
image: KERNEL_IMAGE BOOTLOADER_IMAGE
	@echo "[IMAGE] $(IMAGE)"
	@dd conv=notrunc if=$(BL_BIN) of=$(IMAGE) status=none
	@dd conv=notrunc obs=512 if=$(BIN) of=$(IMAGE) seek=1 status=none


.PHONY:run
run:image
	qemu-system-x86_64  -monitor null -nographic -vnc :100 -drive file=$(IMAGE),if=ide  -gdb tcp::5070