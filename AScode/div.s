global _start

section .data
    oeh dw 34407
    divhh dq 2

    height db 12
    width db 15
    R_area dw 0

    radius db 7
    C_area dw 0

section .text
_start:
    mov bx, word [oeh]

    mov ah, byte [oeh+1]
    mov al, byte [oeh]

    mov al, 64
    mov ah, 0
    mov bl, 4
    div bl

    mov al, byte [height]
    mul byte [width]
    mov word [R_area], ax

    mov al, byte [radius]
    mul al ;; poqRadius
    ;;mov word [powRadius], ax
    mov bl, 22
    mul bl

    mov ebx, 7
    div ebx
    mov dword [C_area], eax


    mov rax, 60
    mov rdi, 0

    syscall