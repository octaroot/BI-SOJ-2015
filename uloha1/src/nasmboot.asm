org 7c00h

%include 'program.asm'

times 1feh - ($ - $$) db 0	;necessary padding

db 055h, 0aah

