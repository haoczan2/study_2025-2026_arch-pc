%include 'in_out.asm'

SECTION .data
    msg_func db "Функция: f(x)=7+2x", 0h
    msg_res db "Результат: ", 0

SECTION .text
global _start
_start:
    mov eax, msg_func
    call sprintLF

    pop ecx
    pop edx
    sub ecx, 1
    jz no_args

    mov esi, 0

process_arg:
    pop eax
    call atoi

    mov ebx, eax
    add eax, eax
    add eax, 7

    add esi, eax

    loop process_arg

    mov eax, msg_res
    call sprint
    mov eax, esi
    call iprintLF
    jmp end

no_args:
    mov eax, msg_res
    call sprint
    mov eax, 0
    call iprintLF

end:
    call quit
