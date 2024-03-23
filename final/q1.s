global _start

section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    testNumber dq 0xABCDEF0011223344
    numTwo db 2

    axeIs db "AX = "
    endline db "",10
    biTem3 db 0

section .text
_start:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, axeIs
    mov rdx, 5
    syscall

    mov rax, qword[testNumber]
    movzx rax, ax

    mov r9, 16
div_biLoop:
    xor dx, dx
    movzx bx, byte[numTwo]
    div bx

    mov byte[biTem3], dl
    add byte[biTem3], '0' ;convert

    push qword[biTem3]

    dec r9
    cmp r9, 0
    jg div_biLoop

    mov r9, 16
out_bi:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, rsp ;print bi
    mov rdx, 1
    syscall
    pop rbx

    dec r9
    cmp r9, 0
    jg out_bi
    
    ;endline
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, endline
    mov rdx, 1
    syscall

    mov rax, 60     ;exit
    mov rdi, 0
    syscall