global _start

section .data
    wNumA dw 1200
    wNumB dw -2000

    gNumA dd 1200
    gNumB dd -2000

    wAns1 dw 0
    wAns2 dw 0

    dNumA dd 42000
    dNumB dd -13000
    dAns1 dd 0
    dAns2 dd 0

    qNumA dq 120000
    qNumB dq 73000000
    qAns1 dq 0
    qAns2 dq 0

    dqAns4 ddq 0

section .text
_start:
    mov ax, word [wNumA]
    imul ax, -13
    mov word [wAns1], ax

    mov eax, dword [gNumA]
    imul eax, dword [gNumB]
    ;mov word [wAns2], ax

    mov eax, dword [dNumA]
    imul eax, 113
    mov dword [dAns1], eax

    mov eax, dword [dNumA]
    imul eax, dword [dNumB]
    mov dword [dAns2], eax

    mov rax, qword [qNumA]
    imul rax, 7096
    mov qword [qAns1], rax

    mov rax, qword [qNumA]
    imul rax, qword [qNumB]
    mov qword [qAns2], rax

    mov rax, 60 ;exit
    mov rdi, 0
    syscall