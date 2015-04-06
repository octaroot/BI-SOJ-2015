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

	mov [24h], CS
	mov [26h], word klav


count:
	push di
	mov di, buf

	

	pop di

print:
	mov di, (80*2-2)*2	;druhy radek, 1 pozici od konce
	mov cl, 10

	std

	mov ah, 00011110b

doPrint:
	mov al, dl
	stosw

	loop doPrint

	cld

	jmp count

klav:
	push ax
	in al, 60h
	mov al, 20h
	out 20h, al
	pop ax
	iret

buf: dw 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h