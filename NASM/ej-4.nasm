section .data
    N1 dd 5               ; Valor de N1
    N2 dd 3               ; Valor de N2
    N3 dd 10              ; Valor de N3
    N4 dd 10              ; Valor de N4
    msgGreater db "N1 es mayor que N2",0x0A, 0 			;0x0A = LF (new line)
    msgZero db "El resultado de N3 - N4 es cero",0x0A, 0

section .text
    global _start

_start:

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
    je printEqualToZero       ; Si N3 == N4, saltar a printEqualToZero

    jmp done

printGreater:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov edi, msgGreater    ; Cargar la dirección de msgGreater en edi (para getStringLength)
    call getStringLength   ; Llamar a la función para calcular la longitud
    mov edx, ecx           ; Longitud del mensaje en edx
    mov ecx, edi           ; Cargar la dirección del mensaje en ecx para sys_write
    int 0x80               ; Llamada al sistema (sys_write)
    jmp _puntoB            ; Retorna a _puntoB

printEqualToZero:
    mov eax, 4             ; sys_write (número de la llamada al sistema)
    mov ebx, 1             ; Descriptor de archivo 1 (salida estándar)
    mov edi, msgZero       ; Cargar la dirección de msgZero en edi (para getStringLength)
    call getStringLength   ; Llamar a la función para calcular la longitud
    mov edx, ecx           ; Longitud del mensaje en edx
    mov ecx, edi           ; Cargar la dirección del mensaje en ecx para sys_write
    int 0x80               ; Llamada al sistema (sys_write)
    jmp done               ; Retorna a _puntoB



; Funcion para calcular la longitud del mensaje
getStringLength:
	mov ecx, 0

findNullTerminator:
        cmp byte [edi + ecx], 0   ; Compara el byte actual con el terminador nulo
        je doneLength             ; Si encuentra el final, salta a doneLength
        inc ecx                   ; Incrementa el contador
        jmp findNullTerminator    ; Repite hasta encontrar el terminador nulo

doneLength:
        ret                       ; Retorna (la longitud estará en ecx)

done:
    ; Salir del programa
    mov eax, 1           ; Código de salida del sistema
    xor ebx, ebx         ; Código de salida 0
    int 0x80             ; Interrupción del sistema para terminar el programa
