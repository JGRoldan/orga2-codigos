%include "io.inc"

section .data
    N5 dd 5                ; Valor de N5
    N6 dd 4                ; Valor de N6
    msgPar db "El resultado tiene paridad par.", 0x0A, 0

    ; Longitudes de las cadenas
    msgParLen equ $-msgPar

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
_puntoF:
    ; Sumar N5 y N6
    mov eax, [N5]          ; Cargar N5 en EAX
    add eax, [N6]          ; Sumar N6 a EAX
    jp printPar           ; Saltar a printPar si la paridad es par

printPar:
    mov eax, 4             ; sys_write
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgPar       ; Cargar la dirección de msgPar en ecx
    mov edx, msgParLen    ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Fin del programa

done:
    mov eax, 1             ; Código de salida del sistema
    xor ebx, ebx           ; Código de salida 0
    int 0x80               ; Interrupción del sistema para terminar el programa
