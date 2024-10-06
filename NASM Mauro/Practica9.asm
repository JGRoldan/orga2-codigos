%include "io.inc"
section .data
mensaje_cf_encendido db "Carry Flag: 1",10,0
len1 equ $ - mensaje_cf_encendido
mensaje_cf_apagado db "Carry Flag: 0",10,0
len2 equ $ - mensaje_cf_apagado

mensaje_pf_encendido db "Parity Flag: 1",10,0
len3 equ $ - mensaje_pf_encendido 
mensaje_pf_apagado db "Parity Flag: 0",10,0
len4 equ  $ - mensaje_pf_apagado

mensaje_af_encendido db "Auxiliary Carry Flag: 1",10,0
len5 equ $ - mensaje_af_encendido
mensaje_af_apagado db "Auxiliary Carry Flag: 0",10,0
len6 equ $ - mensaje_af_apagado

mensaje_zf_encendido db "Zero Flag: 1",10,0
len7 equ $ - mensaje_zf_encendido
mensaje_zf_apagado db "Zero Flag: 0",10,0
len8 equ $ - mensaje_zf_apagado

mensaje_sf_encendido db "Sign Flag: 1",10,0
len9 equ $ - mensaje_sf_encendido
mensaje_sf_apagado db "Sign Flag: 0",10,0
len10 equ $ - mensaje_sf_apagado

mensaje_of_encendido db "Overflow Flag: 1",10,0
len11 equ $ - mensaje_of_encendido
mensaje_of_apagado db "Overflow Flag: 0",10,0
len12 equ $ - mensaje_of_apagado

N1 db 11110000b
N2 db 00001111b
N3 db 125
N4 db 0
;https://en.wikipedia.org/wiki/FLAGS_register
;Información del registro de banderas
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

        mov al,[N1]
        mov bl,[N2]
        add al,bl 
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax 

        test eax,1;Verificar bit 0 - CarryFlag
        jnz CF_ENCENDIDO
        jz CF_APAGADO
        
   CF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_cf_encendido]
        mov edx,len1
        int 0x80
        jmp _testPF
        
   CF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_cf_apagado]
        mov edx,len2
        int 0x80
        jmp _testPF
    
   _testPF:;Parity Flag bit 2
        ;Mascara para bit #2 | 0x4
        mov al,[N1]
        mov bl,[N2]
        add al,bl 
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax
        
        test eax,0x4
        jnz PF_ENCENDIDO
        jz PF_APAGADO
        
   PF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_pf_encendido]
        mov edx,len3
        int 0x80
        jmp _testAF
   
   PF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_pf_apagado]
        mov edx,len4
        int 0x80
        jmp _testAF
        
   _testAF:;Auxiliary Carry Flag bit 4
           ;Mascara para bit 4 -> 0x10
        mov al,[N1]
        mov bl,[N2]
        add al,bl 
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax
        
        test eax,0x10
        jnz AF_ENCENDIDO
        jz AF_APAGADO
        
     AF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_af_encendido]
        mov edx,len5
        int 0x80
        jmp _testZF
        
     AF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_af_apagado]
        mov edx,len6
        int 0x80
        jmp _testZF
      
   _testZF:;Zero Flag bit 6
           ;Mascara para bit 6 -> 0x40
        mov al,[N1]
        mov bl,[N2]
        sub al,bl 
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax
        
        test eax,0x40
        jnz ZF_ENCENDIDO
        jz ZF_APAGADO
       
     ZF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_zf_encendido]
        mov edx,len7
        int 0x80
        jmp _testSF
        
     ZF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_zf_apagado]
        mov edx,len8
        int 0x80
        jmp _testSF
        
   _testSF:;Sign Flag bit 7
           ;Mascara para bit 7 -> 0x80
        mov al,[N1]
        mov bl,[N2]
        sub al,bl 
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax
        
        test eax,0x80
        jnz SF_ENCENDIDO
        jz SF_APAGADO
       
     SF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_sf_encendido]
        mov edx,len9
        int 0x80
        jmp _testOF
        
     SF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_sf_apagado]
        mov edx,len10
        int 0x80
        jmp _testOF
        
 _testOF:;Overflow Flag bit 11
         ;Mascara para bit 11 -> 0x0800
        mov al,[N3]
        mov bl,[N4]
        add al,bl
        
        pushfd  ;Apilar registro EFLAGS
        pop eax ;Desapilo el registro en eax
        
        test eax,0x0800
        jnz OF_ENCENDIDO
        jz OF_APAGADO
       
     OF_ENCENDIDO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_of_encendido]
        mov edx,len11
        int 0x80
        jmp salir
        
     OF_APAGADO:
        mov eax,4
        mov ebx,1
        lea ecx,[mensaje_of_apagado]
        mov edx,len12
        int 0x80
        jmp salir
           


salir: 
        mov eax,1
        xor ebx,ebx
        int 0x80 
   