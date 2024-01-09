global _start

section .data
    bVar db 0
    wVar db 0
    qVar db 0

section .text
_start:
    mov al,0
    mov rbx,0
    mov rbx,-1
    mov rbx,-2
    mov bl,byte [bVar]
    mov bx,word [wVar]
    mov rbx, 0x1234567812345679
    mov [qVar], rbx

    mov rax,60
    mov rdi,0
    syscall