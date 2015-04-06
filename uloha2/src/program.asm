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

;	mov [24h], word klav
;	mov [26h], CS

	std

count:
	mov di, buf + 10
	mov si, di

doCount:

	inc byte [si]
	lodsb

	cmp al, 3ah
	jne print

	and byte [di], 30h
	dec di
	
	cmp si, buf
	je print
	jmp doCount	


	
print:
	mov di, (80*2-2)*2	;druhy radek, 1 pozici od konce
	mov cl, 10

	mov ah, 00011110b
	mov si, buf + 10

doPrint:
	lodsb
	stosw

	loop doPrint

	jmp count

klav:
	push ax
	in al, 60h
	mov al, 20h
	out 20h, al
	pop ax
	iret

buf: db 30h,30h,30h,30h,30h,30h,30h,30h,30h,30,30h