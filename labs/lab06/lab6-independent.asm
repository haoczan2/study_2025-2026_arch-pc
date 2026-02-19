%include 'in_out.asm'

SECTION .data
msg_x: DB 'Введите x: ',0
func_msg: DB 'Вычисляем f(x) = (11 + х) * 2 - 6',0
result_msg: DB 'Результат: ',0

SECTION .bss
x: RESB 80

SECTION .text
GLOBAL _start
_start:
mov eax, func_msg
call sprintLF

mov eax, msg_x
call sprint

mov ecx, x
mov edx, 80
call sread

mov eax, x
call atoi

mov ebx, eax
mov eax, 11
add eax, ebx

mov ebx, 2
mul ebx

sub eax, 6

mov esi, eax

mov eax, result_msg
call sprint

mov eax, esi
call iprintLF

call quit
