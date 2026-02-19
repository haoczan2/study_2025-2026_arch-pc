%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB 'f(x)=',0

SECTION .bss
    x: RESB 80
    res: RESB 80

SECTION .text
GLOBAL _start
_start:
    mov eax, msg
    call sprint

    mov ecx, x
    mov edx, 80
    call sread

    mov eax, x
    call atoi

    call _calculate

    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF

    call quit

_calculate:
    mov ebx, 2
    mul ebx
    add eax, 5
    mov [res], eax
    ret
