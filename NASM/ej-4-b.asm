%include "io.inc"
section .data
    N3 dd 2              ; Valor de N3
    N4 dd 2              ; Valor de N4

    ;Strings
    msgZero db "El resultado de N3 - N4 es cero",0x0A, 0

    ;length de cadenas
    msgZeroLen equ $-msgZero

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging

_puntoB:
    ; b. Si el resultado de N3 - N4 es cero
    mov eax, [N3]       ; Cargar N3 en EAX
    sub eax, [N4]       ; Resta eax(=N3) con N4
    cmp eax, 0          ; Comparar N3 con N4
    je printEqualToZero ; Si N3 == N4, saltar a printEqualToZero

printEqualToZero:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgZero       ; Cargar la dirección de msgZero en ecx
    mov edx, msgZeroLen    ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoB

done:
    ; Salir del programa
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa
