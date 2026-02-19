SECTION .data
	msg: DB 'Введите строку:',10
	msgLen: EQU $-msg

	echoMsg DB 'Вы ввели: ', 0
	echoLen EQU $-echoMsg

SECTION .bss
	buf1: RESB 80
	inputLen RESD 1

SECTION .text
GLOBAL _start
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msgLen
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, buf1
	mov edx, 80
	int 0x80

	mov [inputLen], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, echoMsg
	mov edx, echoLen
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, buf1
	mov edx, [inputLen]
	int 0x80

	mov  eax, 1
	mov  ebx, 0
	int  0x80
