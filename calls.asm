%define SYS_READ  0
%define SYS_WRITE 1
%define SYS_EXIT  60

global _write
_write:
        mov rax, SYS_WRITE
        mov rdi, [rsp + 8]
        mov rsi, [rsp + 16]
        mov rdx, [rsp + 24]
        syscall
        ret

global _read
_read:
        mov rax, SYS_READ
        mov rdi, [rsp + 8]
        mov rsi, [rsp + 16]
        mov rdx, [rsp + 24]
        syscall

global _exit
_exit:
        mov rax, SYS_EXIT
        mov rdi, [rsp + 8]
        syscall
