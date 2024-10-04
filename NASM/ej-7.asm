%include "io.inc"
section .data
    ; Definimos la secuencia de números de 8 bits
    numeros db 1, 2, 6, 3, 4  ; Secuencia de números
    lenNumeros equ $ - numeros ; Longitud de la secuencia

    ; Mensaje de salida
    msgMayor db "El mayor numero es: ", 0x0A, 0  ; Mensaje + salto de línea

section .bss
    mayor resb 1  ; Variable para almacenar el mayor número
    
section .text
    global CMAIN

CMAIN:
    mov ebp, esp       ; Para permitir una depuración correcta
    mov esi, numeros   ; Cargar la dirección del primer número en esi
    mov ecx, lenNumeros ; Cargar el número de elementos de la secuencia en ecx
    
    ; Inicializamos el mayor con el primer número
    mov al, [esi]  ; Cargar el primer número en AL
    mov [mayor], al ; Almacenar el primer número en la variable 'mayor'
    inc esi        ; Avanzar al siguiente número
    dec ecx        ; Reducir el contador, ya evaluamos el primer número
loop_numeros:
    cmp ecx, 0     ; Verificar si hemos recorrido todos los números
    je fin_bucle   ; Si ya no hay más números, saltamos al final

    mov al, [esi]  ; Cargar el siguiente número en AL
    cmp al, [mayor] ; Comparar el número actual con el mayor guardado
    jle no_update  ; Si el número actual es menor o igual, no actualizamos
    
    mov [mayor], al ; Si el número actual es mayor, actualizamos 'mayor'

no_update:
    inc esi        ; Avanzar al siguiente número
    dec ecx        ; Reducir el contador
    jmp loop_numeros ; Repetir el proceso
    
    
fin_bucle:
    ; Al finalizar el bucle, imprimimos el mayor número
    mov eax, 4         ; sys_write (número de la llamada al sistema)
    mov ebx, 1         ; Descriptor de archivo 1 (salida estándar)
    mov ecx, msgMayor  ; Cargar la dirección del mensaje
    mov edx, 20        ; Longitud del mensaje
    int 0x80           ; Llamada al sistema (sys_write)
        
        ; Imprimir el mayor número (convertido a ASCII)
    mov al, [mayor]    ; Cargar el mayor número
    add al, '0'        ; Convertir el número a carácter ASCII
    mov [mayor], al    ; Guardar el carácter en la variable 'mayor'
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, mayor     ; Dirección del número convertido
    mov edx, 1         ; Longitud (1 carácter)
    int 0x80           ; Llamada al sistema (sys_write)
    
    
done:
    ; Salida del programa
    mov eax, 1         ; syscall: exit
    xor ebx, ebx       ; Código de salida 0
    int 0x80           ; Interrupción del sistema para salir