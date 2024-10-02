%include "io.inc"
section .data
    N1 dd 5               ; Valor de N1
    N2 dd 3               ; Valor de N2

    ;Strings
    msgGreater db "N1 es mayor que N2",0x0A, 0 			;0x0A = LF (new line)

    ;length de cadenas
    msgGreaterLen equ $-msgGreater

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
_puntoA:
    ; a. Si N1 es mayor que N2
    mov eax, [N1]         ; Cargar N1 en EAX
    cmp eax, [N2]         ; Comparar N1 con N2
    jg printGreater       ; Si N1 > N2, saltar a printGreater
    jmp done              ; Si no se cumple la condición, terminar el programa

printGreater:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgGreater    ; Cargar la dirección de msgGreater en ecx
    mov edx, msgGreaterLen ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Fin del programa 

done:
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa
