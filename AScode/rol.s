global _start

section .data
    num1 dq 12345678
    num2 dq 73

section .text
_start:
    mov rax, qword[num1]
    mov rcx, 100
loopRoll:
    rol rax,8
    loop loopRoll

    mov rax, 60 ;exit
    mov rdi, 0
    syscall