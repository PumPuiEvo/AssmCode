global _start

section .data
    num1 dq 8
    n1 dq 0
    n2 dq 1
    fiboAns dq 0
    nextNum dq 1

section .text
_start:
    mov rcx, qword[num1] ;set n loop
    mov rax, 1  ;set fibo n=1
    mov rbx, 0  ;set fibo n=0

    cmp qword[num1], 0 ;if num1 = 0 and fuboans = 0
    je zero
    cmp qword[num1], 1 ;if num1 = 0 and fuboans = 1
    je one
    sub rcx, 2
fiboLoop:
    mov rdx, qword[n2]  ;
    mov qword[n1], rdx  ; n2 = n1

    ;mov rdx, qword[nextNum]

    mov rdx, rax        ; 
    mov qword[n2], rdx  ; n2 = vari image for use in fibo loop

    mov rax, qword[n1]  ; new n1
    mov rbx, qword[n2]  ; new n2
    add rax, rbx        ; and n2 = n1 + n2 
    ;mov qword[nextNum], rax

    loop fiboLoop
    mov qword[fiboAns], rax
    jmp endProgram

zero:
    mov qword[fiboAns], 0
    jmp endProgram

one:
    mov qword[fiboAns], 1
    jmp endProgram
endProgram:
    mov rbx, qword[fiboAns]

    mov rax,60 ;exit
    mov rdi,0
    syscall