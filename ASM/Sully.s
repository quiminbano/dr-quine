%define FILE_ATTR (0x2 | 0x40 | 0x200)
%define FILE_PERM (420)
%define NL 10
%define DQT 34
%define PERC 37
%define COUNTER 5
%define OPEN 2
%define CLOSE 3

section .data
    str1 db "Hola somos las putitas", 0
    file_name_template db "Sully_%d.s", 0
    cmd_template db "nasm -f elf64 Sully_%d.s", 0
    linker_template db "cc -Wall -Wextra -Werror Sully_%1$d.o -o Sully_%1$d", 0
    execution_template db "./Sully_%d", 0

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
    mov rcx, COUNTER
    sub rcx, 1
prepare_templates:
    push rcx
    mov rsi, 50
    lea rdi, QWORD[rel file_name]
    lea rdx, QWORD[rel file_name_template]
    call snprintf wrt ..plt
    pop rcx
    lea rdi, QWORD[rel cmd_r]
    lea rdx, QWORD[rel cmd_template]
    mov rsi, 100
    push rcx
    call snprintf wrt ..plt
    pop rcx
    lea rdi, QWORD[rel linker]
    lea rdx, QWORD[rel linker_template]
    mov rsi, 100
    push rcx
    call snprintf wrt ..plt
    pop rcx
    lea rdi, QWORD[rel execution]
    lea rdx, QWORD[rel execution_template]
    mov rsi, 50
    push rcx
    call snprintf wrt ..plt
    pop rcx
open_file:
    mov rax, OPEN
    lea rdi, QWORD[rel file_name]
    mov rsi, FILE_ATTR
    mov rdx, FILE_PERM
    push rcx
    syscall
    pop rcx
    cmp rax, 0
    jge print_to_file
    mov rax, 1
    ret
print_to_file:
    push rax
    mov rdi, rax
    lea rsi, QWORD[rel str1]
    mov rdx, NL
    mov r8, PERC
    lea r9, QWORD[rel str1]
    push r9
    mov r9, rcx
    push rcx
    mov rcx, DQT
    call dprintf wrt ..plt
    pop rcx
    add rsp, 8
    pop rdi
    push rcx
    mov rax, CLOSE
    syscall
    pop rcx
    cmp rcx, 0
    jg assemble_children
    mov rax, 0
    ret
assemble_children:
    lea rdi, QWORD[rel cmd_r]
    call system wrt ..plt
    cmp rax, 0
    je link_children
    mov rax, 1
    ret
link_children:
    lea rdi, QWORD[rel linker]
    call system wrt ..plt
    cmp rax, 0
    je link_children
    mov rax, 1
    ret
execute_children:
    lea rdi, QWORD[rel execution]
    call system wrt ..plt
    cmp rax, 0
    jge return_success
    mov rax, 1
    ret
return_success:
    xor rax, rax
    ret

section .note.GNU-stack  