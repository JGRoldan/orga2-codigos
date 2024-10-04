%include "io.inc"
section .data
N1 dw 4;Numero de 16 bits <-> Word 2 bytes

;8=1000 | 16=10000 | 24=11000 | 32 = 100000
;Los 3 bits menos significativos de los multiplos de 8
;son 000
mensaje_es_multiplo db "El numero es multiplo de 8", 10, 0
len1 equ $ - mensaje_es_multiplo
mensaje_no_multiplo db "El numero NO es multiplo de 8", 10, 0
len2 equ $ - mensaje_no_multiplo


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;Usando instrucciones logicas, escriba un programa que determine si un numero de  16
    ;bits es multiplo de 8
    
    mov ax,[N1]; ax registro de 16 bits
    
    and ax, 7; 7 = 00000111b 
    
    cmp ax,0
    
    jz ESMULTIPLO;Jump Zero
    jnz NOMULTIPLO
    
    ESMULTIPLO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_es_multiplo]
        mov edx,len1
        int 0x80
        jmp salir
        
    NOMULTIPLO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_no_multiplo]
        mov edx,len2
        int 0x80
        jmp salir
        
 salir:
        mov eax,1
        xor ebx,ebx
        int 0x80
        
        