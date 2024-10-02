%include "io.inc"
section .data
    N5 dd -1              ; Valor de N5

    ;Strings
    msgNegative db "N5 es negativo",0x0A, 0

    ;length de cadenas
    msgNegativeLen equ $-msgNegative

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
_puntoD:
    ; d. Si N5 es negativo
    mov eax, [N5]       ; Cargar N5 en EAX
    cmp eax, 0          ; Comparar N5 con 0
    jl printNegative    ; Si N5 < 0, saltar a printNegative
    jmp done            ; Si no se cumple ninguna condición, terminar el programa

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
