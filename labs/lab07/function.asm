%include 'in_out.asm'

SECTION .data
msg_x: DB "Введите х: ",0
msg_a: DB "Введите а: ",0
msg_result: DB "Результат: ",0

SECTION .bss
x: RESB 10
a: RESB 10
result: RESB 10

SECTION .text
GLOBAL _start
_start:
	mov eax, msg_x
	call sprint
	mov ecx, x
	mov edx, 10
	call sread

	mov eax, msg_a
	call sprint
	mov ecx, a
	mov edx, 10
	call sread

	mov eax, x
	call atoi
	mov [x], eax

	mov eax, a
	call atoi
	mov [a], eax

	mov ebx, [x]
	mov ecx, [a]

	cmp ebx, ecx
	jge else_case

	; if x < a: result = 2a - X
	mov eax, ecx
	imul eax, 2
	sub eax, ebx
	jmp end_if

else_case:
	; else: result = 8
	mov eax, 8

end_if:
	mov [result], eax

	mov eax, msg_result
	call sprint
	mov eax, [result]
	call iprintLF

	call quit
