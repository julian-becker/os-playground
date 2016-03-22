[ORG 0]
[BITS 16]

jmp 0x7C0:start
	
start:
	cli
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ax,0xB800
	mov gs,ax
	xor ax,ax
	mov ss,ax
	mov sp,0x7C00

	call ResetFloppy	
	call ReadNextSector
	jmp NextSector
	hlt

ResetFloppy:
	mov si, .resetFloppyMsg
	call PrintString
	xor ah, ah
	xor dl, dl
	int 0x13
	ret
.resetFloppyMsg DB 'Resetting floppy drive...',13,10,0

ReadNextSector:
	mov si, .readingNextSectorMsg
	call PrintString
	mov ah, 2
	mov al, 1
	mov ch, 0 ; cylinder
	mov cl, 2 ; sector
	mov dh, 0 ; head
	mov dl, 0 ; drive
	mov bx, NextSector
	int 0x13
	ret
.readingNextSectorMsg DB 'Reading next sector from floppy drive...',13,10,0



PrintCharacter:	;Procedure to print character on screen
	;Assume that ASCII value is in register AL
	MOV AH, 0x0E	;Tell BIOS that we need to print one charater on screen.
	MOV BH, 0x00	;Page no.
	MOV BL, 0x07	;Text attribute 0x07 is lightgrey font on black background

	INT 0x10	;Call video interrupt
	RET		;Return to calling procedure



PrintString:	;Procedure to print string on screen
		;Assume that string starting pointer is in register SI

.next_character:	;Lable to fetch next character from string
	MOV AL, [SI]	;Get a byte from string and store in AL register
	INC SI		;Increment SI pointer
	OR AL, AL	;Check if value in AL is zero (end of string)
	JZ .exit_function ;If end then return
	CALL PrintCharacter ;Else print the character which is in AL register
	JMP .next_character	;Fetch next character from string
.exit_function:	;End label
	RET		;Return from procedure


; Padding and magic number.
	times 510-($-$$) db 0
	db 0x55
	db 0xAA
; ------------------------------------------
NextSector:
	mov si, someString
	call PrintString
	hlt

someString DB 'Some String from next sector',13,10,0
