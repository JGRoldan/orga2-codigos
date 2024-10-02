%include "io.inc"
section .data
    ;Con desbordamiento
    N5 dd 0x7FFFFFFF      ; Valor de N5 (cercano al máximo valor de 32 bits)
    N6 dd 1               ; Valor de N6

    ;Sin desbordamiento
    ;N5 dd 0xEFFFFFFF      ; Valor de N5 
    ;N6 dd 1               ; Valor de N6

    ;Strings
    msgOverflow db "N5 + N6 produce desbordamiento",0x0A, 0
    msgNoOverflow db "N5 + N6 NO produce desbordamiento",0x0A, 0

    ;length de cadenas
    msgOverflowLen equ $-msgOverflow 
    msgNoOverflowLen equ $-msgNoOverflow 

section .text
    global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
_puntoC:
   ; c. Si N5 + N6 produce desbordamiento.
    mov eax, [N5]         ; Cargar N5 en EAX
    add eax, [N6]          ; Sumar eax (N5) con ebx (N6)
    jo printOverflow      ; Si N5+N6 = overflow, saltar a printOverflow

    ;No produce desbordamiento
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgNoOverflow   ; Cargar la dirección de msgNoOverflow en ecx
    mov edx, msgNoOverflowLen; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done

printOverflow:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgOverflow   ; Cargar la dirección de msgOverflow en ecx
    mov edx, msgOverflowLen; Longitud del mensaje en edx
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done

done:
    ; Salir del programa
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa