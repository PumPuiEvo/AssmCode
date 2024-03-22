global _start

section .data
    filename db "", 0
    filedesc dq 0
    dataInFile db "", 0
    S_IRUSR equ 00400q
    testlen db 0

section .text
_start:

    ; Create filename
    mov rax, 0
    mov rdi, 0
    mov rsi, filename
    mov rdx, 10
    syscall

    ; Create dataInFile
    mov rax, 0
    mov rdi, 0
    mov rsi, dataInFile
    mov rdx, 10
    syscall

    ; Count length of dataInFile
    mov rsi, dataInFile     ; pointer to dataInFile
    xor rcx, rcx        ; counter for length
count_loop:
    cmp byte [rsi + rcx], 0  ; check for null terminator
    je count_done
    inc rcx             ; increment counter
    jmp count_loop
count_done:
    mov r9, rcx
    ; Now rcx holds the length of dataInFile

    ; Create file
    mov rax, 85
    mov rdi, filename
    mov rsi, S_IRUSR
    syscall
    cmp rax, 0
    jl errorOnOpen

    mov qword [filedesc], rax

    ; Write data in file
    mov rax, 1
    mov rdi, qword [filedesc]
    mov rsi, dataInFile
    mov rdx, r9
    syscall
    cmp rax, 0
    jl errorOnWrite
    
    jmp doneeee

errorOnOpen:
    jmp doneeee

errorOnWrite:
    jmp doneeee

; Exit program
doneeee:
    mov rax, 60
    xor rdi, 0
    syscall