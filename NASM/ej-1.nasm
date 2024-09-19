section .data
    N1 db 45        ; N1 es un entero sin signo de 8 bits 
    N2 db 120       ; N2 es otro entero sin signo de 8 bits 
    
    N3 dw -2000     ; N3 es un entero de 16 bits con signo 
    N4 dw 30000     ; N4 es un entero de 16 bits con signo 
    
    N5 dd 100000    ; N5 es un entero de 32 bits
    N6 dd -500000   ; N6 es un entero de 32 bits con signo 
    
    N7 dq 123456789012345678 ; N7 es un entero sin signo de 64 bits 
    N8 dq 987654321098765432 ; N8 es otro entero sin signo de 64 bits 
    
    F1 dd 3.14159   ; F1 es un número en punto flotante de precisión simple 
    
    T db 'Hola, mundo', 0 ; T es una cadena de caracteres ASCII 
