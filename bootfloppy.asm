[ORG 0]
[BITS 16]

jmp 0x7C0:start
	
start:
	cli
	mov ax,cs
	mov ds,ax
	mov ax,0xB800
	mov gs,ax
	xor ax,ax
	mov ss,ax
	mov sp,0x7C00
		
stop:
	mov byte [gs:0x000],'S'
	mov byte [gs:0x001],0x1D
	mov byte [gs:0x002],'T'
	mov byte [gs:0x003],0x1D
	mov byte [gs:0x004],'O'
	mov byte [gs:0x005],0x1D
	mov byte [gs:0x006],'P'
	mov byte [gs:0x007],0x1D
	cli
	hlt


; Padding and magic number.
	times 510-($-$$) db 0
	db 0x55
	db 0xAA
; ------------------------------------------
