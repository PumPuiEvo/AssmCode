section .data
    ; -----
    ; Define standard constants.
    LF 	equ 10 ; line feed
    NULL 	equ 0 ; end of string
    TRUE 	equ 1
    FALSE 	equ 0
    EXIT_SUCCESS equ 0 ; success code
    STDIN 	equ 0 ; standard input
    STDOUT 	equ 1 ; standard output
    STDERR 	equ 2 ; standard error
    SYS_read equ 0 ; read
    SYS_write equ 1 ; write
    SYS_open equ 2 ; file open
    SYS_close equ 3 ; file clos
    SYS_fork equ 57 ; fork
    SYS_exit equ 60 ; terminate
    SYS_creat equ 85 ; file open/create
    SYS_time equ 201 ; get time
    O_CREAT equ 0x40
    O_TRUNC equ 0x200
    O_APPEND equ 0x400
    O_RDONLY equ 000000q ; read only
    O_WRONLY equ 000001q ; write only
    O_RDWR 	equ 000002q ; read and write
    S_IRUSR equ 00400q
    S_IWUSR equ 00200q
    S_IXUSR equ 00100q
    ; -----
    ; Variables/constants for main.
    BUFF_SIZE 	equ 255
    newLine 	db LF, NULL
    header 		db LF, "File Read Example."
            db LF, LF, NULL
    fileName 	db "unknown.dat", NULL
    fileDescrip 	dq 0
    errMsgRead 	db "",34,"unknown.dat",34," not found", LF, NULL
    lenErrMsgRead equ ($-errMsgRead)

    text1 	db "unknown.dat is a text file"
    lentext1 equ ($-text1)
    nottext2 db "unknown.dat is a binay file"
    lennottext2 equ ($-nottext2)

    strlenfile dq 0
    endline db "",10
; -------------------------------------------------------
section .bss
readBuffer 	resb BUFF_SIZE
; -------------------------------------------------------
section .text
global _start
_start:

    openInputFile:
	mov rax, SYS_open ; file open
	mov rdi, fileName ; file name string
	mov rsi, O_RDONLY ; read only access
	syscall ; call the kernel
	cmp rax, 0 ; check for success
	jl errnot_found
	mov qword [fileDescrip], rax ; save descriptor

    mov rax, SYS_read
	mov rdi, qword [fileDescrip]
	mov rsi, readBuffer
	mov rdx, BUFF_SIZE
	syscall
	cmp rax, 0
	jl errorOnRead

    mov rsi, readBuffer
	mov byte [rsi+rax], NULL
	mov rdi, readBuffer
	call checkString

    call exitProgram

errnot_found:

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, errMsgRead
    mov rdx, lenErrMsgRead
    syscall

    call exitProgram

errorOnRead:
    call exitProgram


exitProgram:
    mov rax, 60     ;exit
    mov rdi, 0
    syscall

global checkString
checkString:
	push rbp
	mov rbp, rsp
	push rbx
; -----
; Count characters in string.
	mov rbx, rdi
	mov rdx, 0
strCountLoop:
	cmp byte [rbx], NULL
	je strCountDone
	inc rdx
	inc rbx
	jmp strCountLoop
strCountDone:
	cmp rdx, 0
	je prtDone

    mov qword[strlenfile], rdx
    call textFcheck

; String printed, return to calling routine.
	prtDone:
	pop rbx
	pop rbp
	ret

textFcheck:

    ; mov rdx, qword[strlenfile]
    ; mov eax, SYS_write ; code for write()
	; mov rsi, readBuffer ; addr of characters
	; mov rdi, STDOUT ; file descriptor
	; syscall ; system call
    ; call a_endline

    mov r9, qword[strlenfile]
    dec r9
    xor rcx, rcx
    mov r11, readBuffer
textCheck:
    ;check is a binay
    cmp byte [r11 + rcx], 32
    jl notText
    cmp byte [r11 + rcx], 126
    jg notText
    inc rcx

    dec r9
    cmp r9, 0
    jg textCheck

    ;is a text file
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, text1
    mov rdx, lentext1
    syscall

    call a_endline
    call exitProgram

a_endline:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, endline
    mov rdx, 1
    syscall
    ret

notText:
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, nottext2
    mov rdx, lennottext2
    syscall
    call a_endline
    call exitProgram