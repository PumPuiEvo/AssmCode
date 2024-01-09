global _start

section .data
    bNum1 db 42
    bNum2 db 73
    bAns db 0
    wNum1 dw 4321
    wNum2 dw 1234
    wAns dw 0
    dNum1 dd 42000
    dNum2 dd 73000
    dAns dd 0
    qNum1 dq 42000000
    qNum2 dq 73000000
    qAns dq 0

section .text
_start:
    mov al, byte [bNum1]
    sub al, byte [bNum2]
    mov byte [bAns], al

    mov ax, word [wNum1]
    sub ax, word [wNum2]
    mov word [wAns], ax

    mov eax, dword [dNum1]
    sub eax, dword [dNum2]
    mov dword [dAns], eax

    mov rax, qword [qNum1]
    sub rax, qword [qNum2]
    mov qword [qAns], rax

    dec al 
    dec ax
    dec eax
    dec byte [bAns]
    dec word [wAns]
    dec dword [dAns]

    mov rax, 60 ;exit
    mov rdi, 0
    syscall