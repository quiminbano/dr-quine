;This is a comment in the code
%macro PRINT_STRING 1
    mov rdi, rax
    xor rax, rax
    lea rsi, [rel %1]
    mov rdx, 10
    mov rcx, 39
    mov r8, 37
    mov r9, rsi
    call dprintf wrt ..plt
%endmacro
%macro OPEN_FILE 1
    mov rax, 2
    lea rdi, [rel %1]
    mov rsi, 0x2
    or rsi, 0x40
    or rsi, 0x200
    mov rdx, 420
    syscall
%endmacro
%macro FT_MAIN 0
section .data
    string db ';This is a comment in the code%1$c%3$cmacro PRINT_STRING 1%1$c    mov rdi, rax%1$c    xor rax, rax%1$c    lea rsi, [rel %3$c1]%1$c    mov rdx, 10%1$c    mov rcx, 39%1$c    mov r8, 37%1$c    mov r9, rsi%1$c    call dprintf wrt ..plt%1$c%3$cendmacro%1$c%3$cmacro OPEN_FILE 1%1$c    mov rax, 2%1$c    lea rdi, [rel %3$c1]%1$c    mov rsi, 0x2%1$c    or rsi, 0x40%1$c    or rsi, 0x200%1$c    mov rdx, 420%1$c    syscall%1$c%3$cendmacro%1$c%3$cmacro FT_MAIN 0%1$csection .data%1$c    string db %2$c%4$s%2$c, 0%1$c    file_name db %2$cGrace_kid.s%2$c, 0%1$c    opening_error db %2$cError trying to open/create Grace_kid.s file%2$c, 10, 0%1$c    print_error db %2$cError trying to write information into Grace_kid.s file%2$c, 10, 0%1$csection .text%1$c    global main%1$c    extern dprintf%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    OPEN_FILE file_name%1$c    cmp rax, 0%1$c    jl error_open%1$c    mov QWORD[rsp], rax%1$c    PRINT_STRING string%1$c    mov rdi, QWORD[rsp]%1$c    push rax%1$c    mov rax, 3%1$c    syscall%1$c    pop rax%1$c    cmp rax, 0%1$c    jl error_dprintf%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 0%1$c    ret%1$cerror_open:%1$c    xor rax, rax%1$c    mov rdi, 2%1$c    lea rsi, [rel opening_error]%1$c    call dprintf wrt ..plt%1$c    jmp return_error%1$cerror_dprintf:%1$c    xor rax, rax%1$c    mov rdi, 2%1$c    lea rsi, [rel print_error]%1$c    call dprintf wrt ..plt%1$creturn_error:%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$c%3$cendmacro%1$cFT_MAIN%1$c%1$csection .note.GNU-stack%1$c', 0
    file_name db 'Grace_kid.s', 0
    opening_error db 'Error trying to open/create Grace_kid.s file', 10, 0
    print_error db 'Error trying to write information into Grace_kid.s file', 10, 0
section .text
    global main
    extern dprintf
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    OPEN_FILE file_name
    cmp rax, 0
    jl error_open
    mov QWORD[rsp], rax
    PRINT_STRING string
    mov rdi, QWORD[rsp]
    push rax
    mov rax, 3
    syscall
    pop rax
    cmp rax, 0
    jl error_dprintf
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 0
    ret
error_open:
    xor rax, rax
    mov rdi, 2
    lea rsi, [rel opening_error]
    call dprintf wrt ..plt
    jmp return_error
error_dprintf:
    xor rax, rax
    mov rdi, 2
    lea rsi, [rel print_error]
    call dprintf wrt ..plt
return_error:
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
%endmacro
FT_MAIN

section .note.GNU-stack
