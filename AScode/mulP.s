global _start

section .data
    bNumA db 15
    bNumB db 12
    wAns dw 0
    wAns1 dw 0
    wNumA dw 4321
    wNumB dw 1234
    dAns2 dd 0
    dNumA dd 42000
    dNumB dd 73000
    qAns3 dq 0
    qNumA dq 42000000
    qNumB dq 73000000
    dqAns4 ddq 0

section .text
_start:
    mov al, byte [bNumA]
    mul al
    mov word [wAns], ax

    ;mov rax, qword [qAns3]

    mov al, byte [bNumA]
    mul byte [bNumB]
    mov word [wAns1], ax

    mov ax, word [wNumA]
    mul word [wNumB]
    mov word [dAns2], ax
    mov word [dAns2+2], dx

    mov eax, dword [dNumA]
    mul dword [dNumB]
    mov dword [qAns3], eax
    mov dword [qAns3+4], edx

    mov rax, qword [qNumA]
    mul qword [qNumB]
    mov qword [dqAns4], rax
    mov qword [dqAns4+8], rdx

    mov rax, 60 ;exit
    mov rdi, 0
    syscall