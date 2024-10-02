%include "io.inc"
section .data
    N1 dd 5               ; Valor de N1
    N2 dd 3               ; Valor de N2
    N3 dd 10              ; Valor de N3
    N4 dd 10              ; Valor de N4
    N5 dd -1              ; Valor de N5

    ;Strings
    msgGreater db "N1 es mayor que N2",0x0A, 0 			;0x0A = LF (new line)
    msgZero db "El resultado de N3 - N4 es cero",0x0A, 0
    msgNegative db "N5 es negativo",0x0A, 0

    ;length de cadenas
    msgGreaterLen equ $-msgGreater
    msgZeroLen equ $-msgZero
    msgOverflowLen equ $-msgOverflow 
    msgNegativeLen equ $-msgNegative

section .text
    global CMAIN

CMAIN:

_puntoA:
    ; a. Si N1 es mayor que N2
    mov eax, [N1]         ; Cargar N1 en EAX
    cmp eax, [N2]         ; Comparar N1 con N2
    jg printGreater       ; Si N1 > N2, saltar a printGreater

_puntoB:
    ; b. Si el resultado de N3 - N4 es cero
    mov eax, [N3]       ; Cargar N3 en EAX
    sub eax, [N4]       ; Resta eax(=N3) con N4
    cmp eax, 0          ; Comparar N3 con N4
    je printEqualToZero ; Si N3 == N4, saltar a printEqualToZero

_puntoD:
    ; d. Si N5 es negativo
    mov eax, [N5]       ; Cargar N5 en EAX
    cmp eax, 0          ; Comparar N5 con 0
    jl printNegative    ; Si N5 < 0, saltar a printNegative
    jmp done            ; Si no se cumple ninguna condición, terminar el programa

printGreater:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgGreater    ; Cargar la dirección de msgGreater en ecx
    mov edx, msgGreaterLen ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoB

printEqualToZero:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgZero       ; Cargar la dirección de msgZero en ecx
    mov edx, msgZeroLen    ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoB

printNegative:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgNegative   ; Cargar la dirección de msgNegative en ecx
    mov edx, msgNegativeLen; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoD

done:
    ; Salir del programa
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa
