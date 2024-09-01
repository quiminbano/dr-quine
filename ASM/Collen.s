; This is a comment before program
section .data
    string db "; This is a comment before program%1$csection .data%1$c    string db %2$c%3$s$2%c%1$c%1%csection .text%1%c    global start%1$c    extern printf%1$c%1$cstart:%1$c    lea rdi, QWORD[string]%1$c    mov rsi, 10%1$c    mov rdx, 34%1$c    mov rcx, rdi%1$c    call printf wrt ..plt%1$c    xor rax, rax%1$c    ret%1$c"

section .text
    global start
    extern printf

start:
    lea rdi, QWORD[string]
    mov rsi, 10
    mov rdx, 34
    mov rcx, rdi
    call printf wrt ..plt
    xor rax, rax
    ret
