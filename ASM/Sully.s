%define FILE_ATTR (0x2 | 0x40 | 0x200)
%define FILE_PERM (420)
%define NL 10
%define SQT 39
%define COUNTER 5
%define OPEN 2
%define CLOSE 3
%macro PRINT_ERRORS 1
    xor rax, rax
    mov rdi, 2
    lea rsi, QWORD[rel %1]
    lea rdx, QWORD[rel file_name]
    call dprintf wrt ..plt
%endmacro
%macro CALL_SNPRINTF 3
    mov ecx, DWORD[rsp]
    lea rdi, QWORD[rel %1]
    lea rdx, QWORD[rel %2]
    mov rsi, %3
    xor rax, rax
    call snprintf wrt ..plt
%endmacro

section .data
str1 db '%%define FILE_ATTR (0x2 | 0x40 | 0x200)%1$c%%define FILE_PERM (420)%1$c%%define NL 10%1$c%%define SQT 39%1$c%%define COUNTER %3$d%1$c%%define OPEN 2%1$c%%define CLOSE 3%1$c%%macro PRINT_ERRORS 1%1$c    xor rax, rax%1$c    mov rdi, 2%1$c    lea rsi, QWORD[rel %%1]%1$c    lea rdx, QWORD[rel file_name]%1$c    call dprintf wrt ..plt%1$c%%endmacro%1$c%%macro CALL_SNPRINTF 3%1$c    mov ecx, DWORD[rsp]%1$c    lea rdi, QWORD[rel %%1]%1$c    lea rdx, QWORD[rel %%2]%1$c    mov rsi, %%3%1$c    xor rax, rax%1$c    call snprintf wrt ..plt%1$c%%endmacro%1$c%1$csection .data%1$cstr1 db %2$c%4$s%2$c, 0%1$c    file_name_template db %2$cSully_%%d.s%2$c, 0%1$c    cmd_template db %2$cnasm -f elf64 Sully_%%d.s%2$c, 0%1$c    linker_template db %2$ccc -Wall -Wextra -Werror -Wpedantic Sully_%%1$d.o -o Sully_%%1$d%2$c, 0%1$c    execution_template db %2$c./Sully_%%d%2$c, 0%1$c    file_error db %2$cError trying to create/modify %%s%2$c, 10, 0%1$c    print_error db %2$cError trying to put the code inside %%s%2$c, 10, 0%1$c    asm_error db %2$cError trying to assemble %%s%2$c, 10, 0%1$c    linker_error db %2$cError trying to link %%s%2$c, 10, 0%1$c    execution_error db %2$cError trying to execute %%s%2$c, 10, 0%1$c%1$csection .bss%1$c    file_name resb 50%1$c    cmd_r resb 100%1$c    linker resb 100%1$c    execution resb 50%1$c%1$csection .text%1$c    global main%1$c    extern dprintf%1$c    extern snprintf%1$c    extern system%1$c%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    mov ecx, COUNTER%1$c    sub ecx, 1%1$cprepare_templates:%1$c    mov DWORD[rsp], ecx%1$c    CALL_SNPRINTF file_name, file_name_template, 50%1$c    CALL_SNPRINTF cmd_r, cmd_template, 100%1$c    CALL_SNPRINTF linker, linker_template, 100%1$c    CALL_SNPRINTF execution, execution_template, 50%1$copen_file:%1$c    mov rax, OPEN%1$c    lea rdi, QWORD[rel file_name]%1$c    mov rsi, FILE_ATTR%1$c    mov rdx, FILE_PERM%1$c    syscall%1$c    cmp rax, 0%1$c    jge print_to_file%1$c    PRINT_ERRORS file_error%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cprint_to_file:%1$c    mov DWORD[rsp + 4], eax%1$c    mov edi, eax%1$c    xor rax, rax%1$c    lea rsi, QWORD[rel str1]%1$c    mov dl, NL%1$c    mov cl, SQT%1$c    mov r8d, DWORD[rsp]%1$c    mov r9, rsi%1$c    call dprintf wrt ..plt%1$c    cmp rax, 0%1$c    jge close_file_wo_errors%1$c    xor rdi, rdi%1$c    mov edi, DWORD[rsp + 4]%1$c    mov rax, CLOSE%1$c    syscall%1$c    PRINT_ERRORS print_error%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cclose_file_wo_errors:%1$c    xor rdi, rdi%1$c    mov edi, DWORD[rsp + 4]%1$c    mov rax, CLOSE%1$c    syscall%1$c    cmp DWORD[rsp], 0%1$c    jg assemble_children%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 0%1$c    ret%1$cassemble_children:%1$c    lea rdi, QWORD[rel cmd_r]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    je link_children%1$c    PRINT_ERRORS asm_error%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$clink_children:%1$c    lea rdi, QWORD[rel linker]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    je execute_children%1$c    PRINT_ERRORS linker_error%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$cexecute_children:%1$c    lea rdi, QWORD[rel execution]%1$c    call system wrt ..plt%1$c    cmp rax, 0%1$c    jge return_success%1$c    PRINT_ERRORS execution_error%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    mov rax, 1%1$c    ret%1$creturn_success:%1$c    xor rax, rax%1$c    add rsp, 16%1$c    mov rsp, rbp%1$c    pop rbp%1$c    ret%1$c%1$csection .note.GNU-stack%1$c', 0
    file_name_template db 'Sully_%d.s', 0
    cmd_template db 'nasm -f elf64 Sully_%d.s', 0
    linker_template db 'cc -Wall -Wextra -Werror -Wpedantic Sully_%1$d.o -o Sully_%1$d', 0
    execution_template db './Sully_%d', 0
    file_error db 'Error trying to create/modify %s', 10, 0
    print_error db 'Error trying to put the code inside %s', 10, 0
    asm_error db 'Error trying to assemble %s', 10, 0
    linker_error db 'Error trying to link %s', 10, 0
    execution_error db 'Error trying to execute %s', 10, 0

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
    sub rsp, 16
    mov ecx, COUNTER
    sub ecx, 1
prepare_templates:
    mov DWORD[rsp], ecx
    CALL_SNPRINTF file_name, file_name_template, 50
    CALL_SNPRINTF cmd_r, cmd_template, 100
    CALL_SNPRINTF linker, linker_template, 100
    CALL_SNPRINTF execution, execution_template, 50
open_file:
    mov rax, OPEN
    lea rdi, QWORD[rel file_name]
    mov rsi, FILE_ATTR
    mov rdx, FILE_PERM
    syscall
    cmp rax, 0
    jge print_to_file
    PRINT_ERRORS file_error
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
print_to_file:
    mov DWORD[rsp + 4], eax
    mov edi, eax
    xor rax, rax
    lea rsi, QWORD[rel str1]
    mov dl, NL
    mov cl, SQT
    mov r8d, DWORD[rsp]
    mov r9, rsi
    call dprintf wrt ..plt
    cmp rax, 0
    jge close_file_wo_errors
    xor rdi, rdi
    mov edi, DWORD[rsp + 4]
    mov rax, CLOSE
    syscall
    PRINT_ERRORS print_error
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
close_file_wo_errors:
    xor rdi, rdi
    mov edi, DWORD[rsp + 4]
    mov rax, CLOSE
    syscall
    cmp DWORD[rsp], 0
    jg assemble_children
    add rsp, 16
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
    add rsp, 16
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
    add rsp, 16
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
    add rsp, 16
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret
return_success:
    xor rax, rax
    add rsp, 16
    mov rsp, rbp
    pop rbp
    ret

section .note.GNU-stack
