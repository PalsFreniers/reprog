%include "calls.inc"
%include "utils.inc"

extern _main_loop
extern env_var_list_start

section .text
global _start
_start:
        mov rax, [rsp]
        cmp rax, 1
        jne .too_much_args

        xor rax, rax
.loop_env:
        mov rbx, [rsp + rax * 8 + 8]
        test  rbx, rbx
        jz    .load_env
        add  rax, 1
        jmp  .loop_env
.load_env:
        cmp q
        mov qword [env_var_list_start], [rsp + rax]
        mov qword [env_var_list_start], 
        mov rdx, banner_len
        mov rsi, banner
        mov rdi, STDOUT
        call _write
        
        call _main_loop
        
        mov rdi, rax
        call _exit
.too_much_args:
        mov rdx, too_much_args_error_msg_len
        mov rsi, too_much_args_error_msg
        mov rdi, STDOUT
        call _write
        
        mov rdi, 1
        call _exit

section .data
banner: db "###################################", 0x0A,
        db "#      Reprograming Projects      #", 0x0A,
        db "#       App by PalsFreniers       #", 0x0A,
        db "###################################", 0x0A,
banner_len: equ $-banner
too_much_args_error_msg: db "[Error] -> too much arguments", 0x0A,
                         db "    Usage : reprog", 0x0A,
too_much_args_error_msg_len: equ $-too_much_args_error_msg

