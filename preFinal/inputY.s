global _start

section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    dot db ".", 10
    NULL	equ	0

section .bss
    input_buffer resb 255

section .text

_start:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, dot
    mov rdx, 2
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 255
    syscall

    call printString
    
    mov rax, 60     ;exit
    mov rdi, 0
    syscall


printString:
	push	rbx
	mov	rbx, input_buffer
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL	;calculate string length
	je	strCountDone
	inc	rdx
	inc	rbx
	jmp	strCountLoop
strCountDone:
	cmp	rdx, 0
	je	prtDone
	mov	rax, SYS_write		;write to console
	mov	rsi, input_buffer
	mov	rdi, STDOUT
	syscall
prtDone:
	pop	rbx
    ret
	