; This is a comment before program
section .data
    string db "; This is a comment before program%1$csection .data%1$c    string db %2$c%3$s%2$c, 0%1$c%1$csection .text%1$c    global _start%1$c    extern printf%1$c%1$c_start:%1$c; This is a comment inside the program%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    lea rdi, QWORD string%1$c    call print_me%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    xor rax, rax%1$c    mov rax, 60%1$c    mov rdi, 0%1$c    syscall%1$c%1$cprint_me:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    mov rsi, 10%1$c    mov rdx, 34%1$c    mov rcx, rdi%1$c    call printf wrt ..plt%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    xor rax, rax%1$c    ret%1$c%1$csection .note.GNU-stack%1$c", 0

section .text
    global _start
    extern printf

_start:
; This is a comment inside the program
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rdi, string
    call print_me
    add rsp, 16
    mov rsp, rbp
    pop rbp
    xor rax, rax
    mov rax, 60
    mov rdi, 0
    syscall

print_me:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rsi, 10
    mov rdx, 34
    mov rcx, rdi
    call printf wrt ..plt
    add rsp, 16
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret

section .note.GNU-stack
