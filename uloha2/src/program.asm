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

	mov di, (80*2-2)*2	;druhy radek, 1 pozici od konce

	std

	mov ah, 00011110b
	mov al, 'a'
	stosw
	mov al, 'h'
	stosw
	mov al, 'o'
	stosw
	mov al, 'j'
	stosw

	jmp $