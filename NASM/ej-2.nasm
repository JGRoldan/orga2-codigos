section .data
    N1 db 45                ; N1 es un entero sin signo de 8 bits
    N2 db 120               ; N2 es otro entero sin signo de 8 bits
    
    N3 dw -2000             ; N3 es un entero de 16 bits con signo
    N4 dw 30000             ; N4 es un entero de 16 bits con signo
    
    N5 dd 100000            ; N5 es un entero de 32 bits
    N6 dd -500000           ; N6 es un entero de 32 bits
    
    N7 dq 123456789012345678 ; N7 es un entero de 64 bits
    N8 dq 987654321098765432 ; N8 es otro entero de 64 bits

    ; Espacio para almacenar los resultados
    resultadoN1N2 db 0         ; Para el resultado de N1 + N2 (8 bits)
    resultadoN3N4 dw 0         ; Para el resultado de N3 - N4 (16 bits)
    resultadoN1N2Mul dw 0      ; Para el resultado de N1 * N2 (16 bits, ya que es 8 bits * 8 bits)
    cocienteN3N4 dw 0          ; Cociente de la división N3 / N4
    restoN3N4 dw 0             ; Resto de la división N3 / N4
    resultadoN5N6 dd 0         ; Para el resultado de N5 + N6 (32 bits)
    resultadoN7N8 dq 0         ; Para el resultado de N7 + N8 (64 bits, usando registros de 32 bits)
    cocienteN5N6 dd 0          ; Cociente de la división N5 / N6
    restoN5N6 dd 0             ; Resto de la división N5 / N6

section .bss
    ; No es necesario reservar espacio aquí, lo hacemos en .data.

section .text
    global _start

_start:

    ; a. N1 + N2
    mov al, [N1]        ; Cargar el valor de N1 en el registro AL (8 bits)
    add al, [N2]        ; Sumar N2 al valor de AL
    mov [resultadoN1N2], al  ; Guardar el resultado en memoria
    
    ; b. N3 - N4
    mov ax, [N3]        ; Cargar N3 en AX (16 bits)
    sub ax, [N4]        ; Restar N4 de AX
    mov [resultadoN3N4], ax ; Guardar el resultado en memoria
    
    ; c. N1 * N2 (Multiplicación de 8 bits, resultado puede ser de 16 bits)
    mov al, [N1]        ; Cargar N1 en AL
    mov bl, [N2]        ; Cargar N2 en BL
    mul bl              ; Multiplicar AL * BL (resultado en AX)
    mov [resultadoN1N2Mul], ax ; Guardar el resultado en memoria
    
    ; d. Cociente y resto de la división N3 / N4
    mov ax, [N3]        ; Cargar N3 en AX
    cwd                 ; Extender AX a DX:AX (para división de 16 bits)
    idiv word [N4]      ; Dividir DX:AX entre N4 (resultado en AX, resto en DX)
    mov [cocienteN3N4], ax ; Guardar cociente
    mov [restoN3N4], dx    ; Guardar resto

    ; e. N5 + N6 (Suma de 32 bits)
    mov eax, [N5]       ; Cargar N5 en EAX (32 bits)
    add eax, [N6]       ; Sumar N6 a EAX
    mov [resultadoN5N6], eax ; Guardar el resultado

    ; f. N7 + N8 (Suma de 64 bits, usando registros de 32 bits)
    mov eax, dword [N7]         ; Cargar la parte baja de N7 en EAX
    add eax, dword [N8]         ; Sumar la parte baja de N8
    mov dword [resultadoN7N8], eax ; Guardar la parte baja del resultado

    mov eax, dword [N7+4]       ; Cargar la parte alta de N7 en EAX
    adc eax, dword [N8+4]       ; Sumar la parte alta de N8 con acarreo
    mov dword [resultadoN7N8+4], eax ; Guardar la parte alta del resultado

    ; g. Cociente y resto de la división N5 / N6 (32 bits)
    mov eax, [N5]       ; Cargar N5 en EAX
    cdq                 ; Extender EAX a EDX:EAX para división de 32 bits
    idiv dword [N6]     ; Dividir EDX:EAX entre N6 (resultado en EAX, resto en EDX)
    mov [cocienteN5N6], eax ; Guardar el cociente
    mov [restoN5N6], edx    ; Guardar el resto

    ; Terminar el programa
    mov eax, 1          ; Código de salida del sistema
    int 0x80            ; Llamada al sistema para salir
