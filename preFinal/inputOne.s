global _start

section .data
    STDOUT	equ	1
    STDIN   equ 0
    STDERR 	equ	2	
    SYS_write equ 1
    SYS_read equ 0
    NOTINPUT equ -1

    dot db ".", 10
    input_buffer resd 0

section .text

_start:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, dot
    mov rdx, 2
    syscall

    call read_input
    call show_input

    mov rax, 60     ;exit
    mov rdi, 0
    syscall
    
show_input:
    xor rax, rax ;clear register
    xor rcx, rcx ;clear register
contStr:

    movzx rdx, byte[input_buffer + rcx] 
    cmp rdx, 10 ; check if it's '\n' 
    je done_contStr

    add rax,rdx

    inc rcx
    jmp contStr
done_contStr:
    ret

read_input:
    mov rax, SYS_read
    mov rdi, STDIN
    mov rsi, input_buffer
    mov rdx, 11
    syscall

    cmp rax, NOTINPUT
    je error_input

    ret

error_input:

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, dot
    mov rdx, 1
    syscall

    mov rax, 60     ;exit
    mov rdi, 0
    syscall