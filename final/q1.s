global _start

section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    testNumber dq 0xABCDEF0011223344
    hexuse dw 0
    numTwo db 2

    axeIs db "AX = "
    temp db ""
    biTem2 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

section .bss
    biTem resb 16

section .text
_start:
    mov rax, qword[testNumber]
    mov word[hexuse], ax
    movzx rax, ax

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, axeIs
    mov rdx, 5
    syscall

    mov r9, 16
div_biLoop:
    xor dx, dx
    movzx bx, byte[numTwo]
    div bx
    push dx
    mov byte[biTem2+r9], dl

    dec r9
    cmp r9, 0
    jg div_biLoop

    mov r9, 16

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, axeIs
    mov rdx, 5
    syscall
out_bi:
    pop rbx
    ;lea rax, [rbx + '0']
    ;push rax
    add rbx, '0'
    mov byte[temp], bl
    ;push rbx

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, biTem2
    mov rdx, 1
    syscall

    dec r9
    cmp r9, 0
    ;pop rbx
    jg out_bi
    ;pop rax
    
    mov rax, 60     ;exit
    mov rdi, 0
    syscall