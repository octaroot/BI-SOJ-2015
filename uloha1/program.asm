
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

	mov dx, 1137h
	push dx

	mov ah,0fh	;barva

		;CODE BEGINS HERE

doshit:
	mov al,dl
	shr dx,4
	and al,0x0f
	cmp al, 0
	je konec

print	add al, '0'
	cmp al, '9'
	jle putchar
	add al, 'A' - 10 - '0'
	
putchar	push ax
	
	jmp doshit

konec	pop ax
	stosw
	pop ax
	stosw
	pop ax
	stosw
	pop ax
	stosw
	jmp $

;	pop dx
;	shrd 4,dx,dx
;	push dx	
;	and dx,15h
;	mov ax,dx
;	jmp print


