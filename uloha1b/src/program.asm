	push dx
	push cx
	push bx
	push ax
	pushf
	push ss
	push es
	push ds
	call (0h):next
next:
	pop eax
	sub eax, 0xd
	push eax
	mov ax, sp         ;fix SP value
	add ax, 0x14
	push ax
	push bp
	push di
	push si
                
	xor ax,ax	;set segments to known values
    	mov ss,ax
	mov ds,ax
    
	mov al,3	;set VGA mode 80x25
	int 10h
	mov ax,0b800h
	mov es,ax
	cld


	mov si, nazvy          ;zdroj dat
    	xor ax, ax
    
    	mov bp, 14
    
printIt:
	add ah, 00001001b
	pop dx
	lodsb
	stosw
	lodsb
	stosw
	mov al, ':'
	stosw
	mov cx, 4
	
print:
	rol dx,4
	mov al,dl
	and al,0x0f

	add al, '0'
	cmp al, '9'
	jle putchar
	add al, 'A' - 10 - '0'
	
putchar:
	stosw
	loop print
    
    mov al, ' '
	stosw
    
    
    dec bp
    jnz printIt
    
	jmp $

nazvy	db "SIDIBPSPIPCSDSESSSFLAXBXCXDX", 0h