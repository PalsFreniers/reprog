%define SYS_READ  0
%define SYS_WRITE 1
%define SYS_EXIT  60

%include "utils.inc"

global _write
_write:
        mov rax, SYS_WRITE
        syscall
        ret

global _read
_read:
        mov rax, SYS_READ
        syscall
        ret

global _exit
_exit:
        mov rax, SYS_EXIT
        syscall
