%include "calls.inc"
%include "utils.inc"

;extern _get_cmd

section .text
global _main_loop
_main_loop:
.loop_start:
        mov rdx, prompt_len
        mov rsi, prompt
        mov rdi, STDOUT
        call _write
        
        mov rdx, 100
        mov rsi, cmd
        mov rdi, STDIN
        call _read
        
        cmp rax, 0
        jle .cmd_len_error
        
        mov rdi, cmd
        call _get_cmd
        
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
