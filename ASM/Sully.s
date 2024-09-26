%define FILE_ATTR (0x2 | 0x40 | 0x200)
%define FILE_PERM (420)
%define NL 10
%define SQT 39
%define PERC 37
%define COUNTER 5
%define OPEN 2
%define CLOSE 3
%macro PRINT_ERRORS 1
    xor rax, rax
    mov rdi, 2
    mov rsi, QWORD[rel %1]
    mov rdx, QWORD[rel file_name]
    mov rcx, 10
    call dprintf wrt ..plt
%endmacro

section .data
    str1 db '%3$cdefine FILE_ATTR (0x2 | 0x40 | 0x200)%1$c%3$cdefine FILE_PERM (420)%1$c%3$cdefine NL 10%1$c%3$cdefine SQT 39%1$c%3$cdefine PERC 37%1$c%3$cdefine COUNTER %4$d%1$c%3$cdefine OPEN 2%1$c%3$cdefine CLOSE 3%1$c%3$cmacro PRINT_ERRORS 1%1$c    xor rax, rax%1$c    mov rdi, 2%1$c    mov rsi, QWORD[rel %3$c1]%1$c    mov rdx, QWORD[rel file_name]%1$c    mov rcx, 10%1$c    call dprintf wrt ..plt%1$c%3$cendmacro%1$c%1$csection .data%1$c    str1 db %2$c%5$s%2$c, 0%1$c    file_name_template db %2$cSully_%d.s%2$c, 0%1$c    cmd_template db %2$cnasm -f elf64 Sully_%d.s%2$c, 0%1$c    linker_template db %2$ccc -Wall -Wextra -Werror -Wpedantic Sully_%1$d.o -o Sully_%1$d%2$c, 0%1$c    execution_template db %2$c./Sully_%d%2$c, 0%1$c    file_error db %2$cError trying to create/modify %s%c%2$c, 0%1$c    print_error db %2$cError trying to put the code inside %s%c%2$c, 0%1$c    asm_error db %2$cError trying to assemble %s%c%2$c, 0%1$c    linker_error db %2$cError trying to link %s%c%2$c, 0%1$c    execution_error db %2$cError trying to execute %s%c%2$c, 0%1$c%1$csection .bss%1$c    file_name resb 50%1$c    cmd_r resb 100%1$c    linker resb 100%1$c    execution resb 50%1$c%1$csection .text%1$c    global main%1$c    extern dprintf%1$c    extern snprintf%1$c    extern system%1$c%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 32%1$c    mov rcx, COUNTER%1$c    sub rcx, 1%1$cprepare_templates:%1$c    mov QWORD[rsp + 8], rcx%1$c    mov rsi, 50%1$c    lea rdi, QWORD[rel file_name]%1$c    lea rdx, QWORD[rel file_name_template]%1$c    xor rax, rax%1$c    call snprintf wrt ..plt%1$c    mov rcx, QWORD[rsp + 8]%1$c    lea rdi, QWORD[rel cmd_r]%1$c    lea rdx, QWORD[rel cmd_template]%1$c    mov rsi, 100%1$c    xor rax, rax%1$c    call snprintf wrt ..plt%1$c    mov rcx, QWORD[rsp + 8]%1$c    lea rdi, QWORD[rel linker]%1$c    lea rdx, QWORD[rel linker_template]%1$c    mov rsi, 100%1$c    xor rax, rax%1$c    call snprintf wrt ..plt%1$c    mov rcx, QWORD[rsp + 8]%1$c    lea rdi, QWORD[rel execution]%1$c    lea rdx, QWORD[rel execution_template]%1$c    mov rsi, 50%1$c    xor rax, rax%1$c    call snprintf wrt ..plt%1$copen_file:%1$c    mov rax, OPEN%1$c    lea rdi, QWORD[rel file_name]%1$c    mov rsi, FILE_ATTR%1$c    mov rdx, FILE_PERM%1$c    syscall%1$c    cmp rax, 0%1$c    jge print_to_file%1$c    PRINT_ERRORS file_error%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cprint_to_file:%1$c    mov QWORD[rsp + 16], rax%1$c    mov rdi, rax%1$c    xor rax, rax%1$c    lea rsi, QWORD[rel str1]%1$c    mov QWORD[rsp], rsi%1$c    mov rdx, NL%1$c    mov r8, PERC%1$c    mov r9, QWORD[rsp + 8]%1$c    mov rcx, SQT%1$c    call dprintf wrt ..plt%1$c    cmp rax, 0%1$c    jge close_file_wo_errors%1$c    mov rdi, QWORD[rsp + 16]%1$c    mov rax, CLOSE%1$c    syscall%1$c    PRINT_ERRORS print_error%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cclose_file_wo_errors:%1$c    mov rdi, QWORD[rsp + 16]%1$c    mov rax, CLOSE%1$c    syscall%1$c    cmp QWORD[rsp + 8], 0%1$c    jg assemble_children%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 0%1$c    ret%1$cassemble_children:%1$c    lea rdi, QWORD[rel cmd_r]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    je link_children%1$c    PRINT_ERRORS asm_error%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$clink_children:%1$c    lea rdi, QWORD[rel linker]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    je execute_children%1$c    PRINT_ERRORS linker_error%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cexecute_children:%1$c    lea rdi, QWORD[rel execution]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    jge return_success%1$c    PRINT_ERRORS execution_error%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$creturn_success:%1$c    xor rax, rax%1$c    add rsp, 32%1$c    mov rsp, rbp%1$c    pop rbp%1$c    ret%1$c%1$csection .note.GNU-stack%1$c', 0
    file_name_template db 'Sully_%d.s', 0
    cmd_template db 'nasm -f elf64 Sully_%d.s', 0
    linker_template db 'cc -Wall -Wextra -Werror -Wpedantic Sully_%1$d.o -o Sully_%1$d', 0
    execution_template db './Sully_%d', 0
    file_error db 'Error trying to create/modify %s%c', 0
    print_error db 'Error trying to put the code inside %s%c', 0
    asm_error db 'Error trying to assemble %s%c', 0
    linker_error db 'Error trying to link %s%c', 0
    execution_error db 'Error trying to execute %s%c', 0

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
    PRINT_ERRORS file_error
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
    mov r9, QWORD[rsp + 8]
    mov rcx, SQT
    call dprintf wrt ..plt
    cmp rax, 0
    jge close_file_wo_errors
    mov rdi, QWORD[rsp + 16]
    mov rax, CLOSE
    syscall
    PRINT_ERRORS print_error
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
close_file_wo_errors:
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
    PRINT_ERRORS asm_error
    add rsp, 32
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
link_children:
    lea rdi, QWORD[rel linker]
    call system wrt ..plt
    cmp rax, 0
    je execute_children
    PRINT_ERRORS linker_error
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
    PRINT_ERRORS execution_error
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
