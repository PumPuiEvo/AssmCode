global _start

section .data
    num1 dw 50000

section .text
_start:
    mov ax, word [num1]
    
    shl al, 1

    mov rax,60 ;exit
    mov rdi,0
    syscall