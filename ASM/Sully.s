%define FILE_ATTR (0x2 | 0x40 | 0x200)
%define FILE_PERM (420)
%define NL 10
%define SQT 39
%define PERC 37
%define COUNTER 5
%define OPEN 2
%define CLOSE 3

section .data
    str1 db 'Hehe %1$c, %2$c, %3$c, %4$d, %5$s', 0
    file_name_template db 'Sully_%d.s', 0
    cmd_template db 'nasm -f elf64 Sully_%d.s', 0
    linker_template db 'cc -Wall -Wextra -Werror Sully_%1$d.o -o Sully_%1$d', 0
    execution_template db './Sully_%d', 0

section .bss
    file_name resb 50
    cmd_r resb 100
    linker resb 100
    execution resb 50

section .text
    global main
    extern dprintf
    extern snprintf
    extern system

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rcx, COUNTER
    sub rcx, 1
prepare_templates:
    mov QWORD[rsp + 8], rcx
    mov rsi, 50
    lea rdi, QWORD[rel file_name]
    lea rdx, QWORD[rel file_name_template]
    xor rax, rax
    call snprintf wrt ..plt
    mov rcx, QWORD[rsp + 8]
    lea rdi, QWORD[rel cmd_r]
    lea rdx, QWORD[rel cmd_template]
    mov rsi, 100
    xor rax, rax
    call snprintf wrt ..plt
    mov rcx, QWORD[rsp + 8]
    lea rdi, QWORD[rel linker]
    lea rdx, QWORD[rel linker_template]
    mov rsi, 100
    xor rax, rax
    call snprintf wrt ..plt
    mov rcx, QWORD[rsp + 8]
    lea rdi, QWORD[rel execution]
    lea rdx, QWORD[rel execution_template]
    mov rsi, 50
    xor rax, rax
    call snprintf wrt ..plt
open_file:
    mov rax, OPEN
    lea rdi, QWORD[rel file_name]
    mov rsi, FILE_ATTR
    mov rdx, FILE_PERM
    syscall
    cmp rax, 0
    jge print_to_file
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
print_to_file:
    mov QWORD[rsp + 16], rax
    mov rdi, rax
    xor rax, rax
    lea rsi, QWORD[rel str1]
    mov QWORD[rsp], rsi
    mov rdx, NL
    mov r8, PERC
    mov r9, QWORD[rsp + 16]
    mov rcx, SQT
    call dprintf wrt ..plt
    mov rdi, QWORD[rsp + 16]
    mov rax, CLOSE
    syscall
    cmp QWORD[rsp + 8], 0
    jg assemble_children
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 0
    ret
assemble_children:
    lea rdi, QWORD[rel cmd_r]
    call system wrt ..plt
    cmp rax, 0
    je link_children
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
link_children:
    lea rdi, QWORD[rel linker]
    call system wrt ..plt
    cmp rax, 0
    je link_children
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
execute_children:
    lea rdi, QWORD[rel execution]
    call system wrt ..plt
    cmp rax, 0
    jge return_success
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
return_success:
    xor rax, rax
    add rsp, 32
    mov rsp, rbp
    pop rbp
    ret

section .note.GNU-stack  
