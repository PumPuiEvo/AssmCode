global _start

section .data
    file_desc dq 0
    READ_ONLY equ 000000q
    data_read dq "", 0

section .bss
    filename resb 256

section .text
_start:
    ; Input filename
    mov rax, 0
    mov rdi, 0
    mov rsi, filename
    mov rdx, 10
    syscall

    ; Open file for read
    mov rax, 2
    mov rdi, filename
    mov rsi, READ_ONLY
    syscall
    
    mov qword [file_desc], rax
    ; Read data in file
    mov rax, 0
    mov rdi, qword [file_desc]
    mov rsi, data_read
    mov rdx, 10
    syscall

    mov rax, data_read
    xor rbx, rbx
; Count length string
count_string:
    cmp qword [rax+(4*rbx)], 0
    je print_string

    inc rbx
    jmp count_string
; Print data in file
print_string:
    mov rax, 1
    mov rdi, 1
    mov rsi, data_read
    mov rdx, rbx
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall