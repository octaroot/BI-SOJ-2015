jmp setup
setup:
	xor ax,ax	;set segments to known values
    	mov ss,ax
	mov ds,ax
    
	mov ax,1112h	;set VGA mode 80x25
	int 10h
	mov ax,0b800h
	mov es,ax

	xor di,di
    
	mov cx, 4000
	mov ah, 00000111b
	rep
	stosw
   

	jmp $