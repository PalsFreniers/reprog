%include "calls.inc"
%include "utils.inc"

extern _handle_cmd

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
        call _handle_cmd

        cmp rax, 2
        je .quit_broadcast
        cmp rax, 3
        je .handle_error
        
        jmp .loop_start

.quit_broadcast:
        mov rax, 0
        ret

.handle_error:
        mov rdx, error_handle_msg_len
        mov rsi, error_handle_msg
        mov rdi, STDOUT
        call _write
        jmp .loop_start

.cmd_len_error:
        mov rdx, error_command_len_len
        mov rsi, error_command_len
        mov rdi, STDOUT
        call _write
        jmp .error_return

.error_return:
        mov rax, 1
        ret

section .data
prompt: db "[reprog] -> "
prompt_len: equ $-prompt

error_command_len: db "[Error] -> while reading input from user", 0x0A
error_command_len_len: equ $-error_command_len
error_handle_msg: db "[Error] -> unknown command", 0x0A
error_handle_msg_len: equ $-error_handle_msg

section .bss
cmd: resb 100
