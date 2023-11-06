%include "calls.inc"
%include "utils.inc"

section .text
global _main_loop
_main_loop:
.loop_start:
        push prompt_len
        push prompt
        push STDOUT
        call _write
        
        push 100
        push cmd
        push STDIN
        call _read

        mov rdi, rax
        call dump

        
        cmp rax, 0
        jle .cmd_len_error

        add rax, cmd
        mov byte [rax], 0x0A
        sub rax, cmd
        add rax, 1

        mov [cmd_len], rax

        push qword [cmd_len]
        push cmd
        push STDOUT
        call _write

        jmp .loop_start

.cmd_len_error:
       push error_command_len_len
       push error_command_len
       push STDOUT
       call _write
       mov rax, 1
       ret

section .data
prompt: db "[reprog] -> "
prompt_len: equ $-prompt

error_command_len: db "Error while reading input from user", 0x0A
error_command_len_len: equ $-error_command_len

section .bss
cmd: resb 100
cmd_len: resq 1
