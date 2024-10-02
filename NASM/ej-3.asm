%include "io.inc"
section .data
    num1 dq 0x1111111122222222, 0x3333333344444444 ; 1er nro de 128 bits
    num2 dq 0x3333333322222222, 0x1111111100000000 ; 2do número 128b
    result dq 0x00000000000000000, 0x0000000000000000 ; Resultado

section .bss
; Espacio para almacenar los resultados

section .text
    global CMAIN

CMAIN:
    ; Mover los valores a los registros de propósito general (de a 8b)
    mov eax, dword[num1]
    mov ebx, dword[num1+4]
    mov ecx, dword[num1+8]
    mov edx, dword[num1+12]

    ; Sumar los valores de los números con los valores de losregistros
    add eax, dword[num2]
    adc ebx, dword[num2+4]
    adc ecx, dword[num2+8]
    adc edx, dword[num2+12]

    ; Mover los valores del resultado a la sección .data
    mov dword[result], eax
    mov dword[result+4], ebx
    mov dword[result+8], ecx
    mov dword[result+12], edx

    ; Terminar el programa
    mov eax,1 ; Código de salida del sistema
    mov ebx,0 ;código de salida "0" (no error)
    int 0x80  ; Llamada al sistema para salir
