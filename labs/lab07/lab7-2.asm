%include 'in_out.asm'

SECTION .data
msg: DB "Наименьшее число: ",0
a: DD 17
b: DD 23
c: DD 45

SECTION .bss
min: RESB 10

SECTION .text
GLOBAL _start
_start:
    mov eax, [a]
    mov [min], eax

    cmp eax, [b]
    jl check_c
    mov eax, [b]
    mov [min], eax
check_c:
    mov eax, [min]
    cmp eax, [c]
    jl finish
    mov eax, [c]
    mov [min], eax
finish:
    mov eax, msg
    call sprint
    mov eax, [min]
    call iprintLF
    call quit
