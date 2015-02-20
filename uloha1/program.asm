
			;VGA SETUP
setup	xor ax,ax	;set segments to known values
	mov sp,7e00h
	mov ss,ax
	mov ds,ax
	mov al,3	;set VGA mode 80x25
	int 10h
	mov ax,0b800h
	mov es,ax
	cld


			;CODE BEGINS HERE
	mov ah,0fh	;barva
	push 0xface
	call printIt
	push 0xb00c
	call printIt
	jmp $


	
printIt:
	pop cx
	pop dx
	push cx
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
	
	ret
