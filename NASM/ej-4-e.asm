%include "io.inc"
section .data
    N7 dd 0x7FFFFFFF      ; Valor de N7
    N8 dd 1               ; Valor de N8

    ;Strings
    msgCarry db "N7 + N8 produce Carry",0x0A, 0 			;0x0A = LF (new line)

    ;length de cadenas
    msgCarryLen equ $-msgCarry

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
_puntoE:
    ; a. Si N1 es mayor que N2
    mov eax, [N7]         ; Cargar N1 en EAX
    cmp eax, [N8]         ; Comparar N1 con N2
    jc printCarry       ; Si N1 > N2, saltar a printGreater
    jmp done              ; Si no se cumple la condición, terminar el programa

printCarry:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgCarry       ; Cargar la dirección de msgCarry en ecx
    mov edx, msgCarryLen    ; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoB

done:
    ; Salir del programa
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa
