jmp setup
setup:
	xor ax,ax		;set segments to known values
    	mov ss,ax
	mov ds,ax
    
	mov ax,1112h		;set VGA mode 80x50
	int 10h
	mov ax,0b800h
	mov es,ax

    
	mov cx, 4000
	mov ah, 00000111b
	rep
	stosw

	xor dx,dx

count:
	inc dx

	

print:

	mov di, (80*2-2)*2	;druhy radek, 1 pozici od konce

	std

	mov ah, 00011110b
	mov al, dl
	stosw

	cld

	jmp count

	jmp $