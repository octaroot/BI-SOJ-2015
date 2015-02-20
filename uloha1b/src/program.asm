;push-a-roo

	;chtel jsem dodrzet poradi ze screenu, jinak bychpouzil pusha

	push dx
	push cx
	push bx
	push ax
	pushf		;flags
	push ss
	push es
	push ds
	push cs
	call next	;retrieve IP my calling and abusing the pushed value
next	pop eax
	sub eax, 0xc
	push eax
	mov ax, sp	;fix SP value
	add ax, 0x14
	push ax
	push bp
	push di
	push si

			;VGA SETUP
setup	xor ax,ax	;set segments to known values
	mov al,3	;set VGA mode 80x25
	int 10h
	mov ax,0b800h
	mov es,ax
	cld


			;CODE BEGINS HERE
	mov ah,0fh	;barva
	mov si, nazvy

	mov bl, 0

	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	call printIt
	jmp $


	
printIt:
	add bl, 00001001b
	mov ah, bl
	pop cx
	pop dx
	push cx
	lodsb		; print register name
	stosw
	lodsb
	stosw
	mov al, ':'
	stosw
	mov cx, 4
	
print:
	mov al,dl
	shr dx,4
	and al,0x0f

	add al, '0'
	cmp al, '9'
	jle putchar
	add al, 'A' - 10 - '0'
	
putchar:
	push ax
	
	loop print
	mov cx, 4

konec	pop ax
	stosw
	loop konec
	
	mov al, ' '
	stosw

	ret


nazvy	db "SIDIBPSPIPCSDSESSSFLAXBXCXDX",0