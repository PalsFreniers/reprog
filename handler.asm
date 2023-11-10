%include "calls.inc"
%include "utils.inc"
%include "str.inc"
%include "cmd_handler.inc"

global _handle_cmd
_handle_cmd:
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx

        cmp rdi, 0
        jne .not_null_param
        mov rax, 0
        ret
        
.not_null_param:
        call _del_nl
        mov qword [parse_cmd_parameter], rax 

        mov dword [parse_cmd_iterator], 0
        mov rbx, parse_cmd_start
.start_for:
        cmp byte [rax], 0
        je .end_for
        cmp byte [rax], 32
        je .end_for
        
        mov cl, [rax]
        mov byte [rbx], cl

        inc rax
        inc rbx
        inc dword [parse_cmd_iterator]
        jmp .start_for

.end_for:

        mov rdi, parse_cmd_start
        mov rsi, parse_cmd_quit
        call _strcmp

        cmp rax, 0
        je .else_cmd_quit

        mov rax, 2
        ret

.else_cmd_quit:
        mov rdi, parse_cmd_start
        mov rsi, parse_cmd_list
        call _strcmp

        cmp rax, 0
        je .else_cmd_list
        
        mov rdi, [parse_cmd_parameter]
        add edi, [parse_cmd_iterator]
        call _cmd_list_handler
        ret

.else_cmd_list:
        mov rax, 0
        ret
        

section .data
parse_cmd_list: db "list", 0
parse_cmd_quit: db "quit", 0

section .bss
parse_cmd_start: resb 32
parse_cmd_iterator: resd 1
parse_cmd_parameter: resq 1
