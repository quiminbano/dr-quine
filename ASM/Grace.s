;This is a comment in the code
%macro PRINT_STRING 1
    mov rdi, %1
    mov rsi, 10
    mov rdx, 34
    mov rcx, 25
	mov r8, %1
    call printf wrt ..plt
%endmacro
%macro OPEN_FILE 1
    mov rax, 2
    mov rdi, %1
    mov rsi, 2
    mov rdx, 420
    syscall
%endmacro
%macro FT_MAIN 0
section .data
    string db ";This is a comment in the code%1$c%3$cmacro PRINT_STRING 1%1$c    mov rdi, %3$c1%1$c    mov rsi, 10%1$c    mov rdx, 34%1$c    mov rcx, 25%1$c	mov r8, %3$c1%1$c    call printf wrt ..plt%1$c%3$cendmacro%1$c%3$cmacro OPEN_FILE 1%1$c    mov rax, 2%1$c    mov rdi, %3$c1%1$c    mov rsi, 2%1$c    mov rdx, 420%1$c    syscall%1$c%3$cendmacro%1$c%3$cmacro FT_MAIN 0%1$csection .data%1$c    string db %2$c%4$c%2$c%1$c    file_name db %2$cGrace_kid.s%2$c%1$csection .text%1$c    global _start%1$c    extern printf%1$c_start:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    OPEN_FILE file_name%1$c    cmp rax, 0%1$c    jl return_error%1$c    mov rdi, rax%1$c    push rdi%1$c    mov rax, 33%1$c    mov rsi, 1%1$c    syscall%1$c    cmp rax, 0%1$c    jl closefile_and_error%1$c    PRINT_STRING string%1$c    pop rdi%1$c    mov rax, 3%1$c    syscall%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 60%1$c    mov rdi, 0%1$c    syscall%1$cclosefile_and_error:%1$c    pop rdi%1$c    mov rax, 3%1$c    syscall%1$creturn_error:%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 60%1$c    mov rdi, 1%1$c    syscall%1$c%3$cendmacro%1$cFT_MAIN"
    file_name db "Grace_kid.s"
section .text
    global _start
    extern printf
_start:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    OPEN_FILE file_name
    cmp rax, 0
    jl return_error
    mov rdi, rax
    push rdi
    mov rax, 33
    mov rsi, 1
    syscall
    cmp rax, 0
    jl closefile_and_error
    PRINT_STRING string
    pop rdi
    mov rax, 3
    syscall
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall
closefile_and_error:
    pop rdi
    mov rax, 3
    syscall
return_error:
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 1
    syscall
%endmacro
FT_MAIN