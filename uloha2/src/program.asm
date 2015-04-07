jmp setup
setup:

	cli
	mov [24h], word klav
	mov [26h], CS
	sti

	xor ax,ax		;set segments to known values
    	mov ss,ax
	mov di,ax
	mov bp,ax
    
	mov ax,1112h		;set VGA mode 80x50
	int 10h
	mov ax,0b800h
	mov es,ax
	mov ds,ax

	mov cx, 4000
	mov ah, 00000111b
	rep
	stosw

	std

	mov di, buf + 10
	mov cx, 10
	mov al, 30h
	rep
	stosb

count:
	mov di, buf + 10
	mov si, di

doCount:

	lodsb
	inc al
	
	cmp al, 3ah
	jne beforePrint

	and al, 30h
	stosb
	
	cmp si, buf
	je print
	jmp doCount	

beforePrint:
	stosb
	
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
	cli
	push ax
	push es
	push di
	push cx
	push dx

	in al, 60h
	mov cl, 1
	shl al, cl
	jnc konecPreruseni
	

	mov ax,0b800h
	mov es,ax

	xor di,di
;1,0
;54,28
getRand:			;AH=mod, AL=quotient
	mov ax, bp
	mov bx, 33333
	mul bx
	add ax, 1
	mov bp,ax		;bp=ax=m_new

	xor dx,dx
	mov cx, 65
	div cx
	push ax			;al je /, ah je mod

	add dx,dx
	xchg di,dx		;na kazdy znak 2bity

	pop ax			;a ted quotient mod 44
	mov cx, 44
	div cx
	xchg ax,dx
	mov cx, 160		;jeden radek += 160
	mul cx
	add di, ax		;a pridat


	in al, 60h
	mov bl,al
	mov bh,al
	and bl, 07h
	and bh, 070h
	shr bh, 4
	and bl,bh
	jne barvaOK
	not al	

barvaOK:
	mov ah, 0DBh

	xchg al,ah

	cld

	mov dh, 2
super:	mov dl, 7
outer:	mov cx, 8
inner:	stosw
	loop inner
	add di, 160 - 16
	dec dl
	jnz outer
	sub di, 7 * 160 - 16
	rol ah, 4
	dec dh
	jnz super

	std

konecPreruseni:

	mov al, 20h
	out 20h, al

	pop dx
	pop cx
	pop di
	pop es
	pop ax

	sti
	iret


buf:	dw 8000