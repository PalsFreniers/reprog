%include "calls.inc"
%include "utils.inc"

extern _main_loop

section .text
global _start
_start:
        push banner_len
        push banner
        push STDOUT
        call _write

        call _main_loop

        push rax
        call _exit

section .data
banner: db "###################################", 0x0A,
        db "#      Reprograming Projects      #", 0x0A,
        db "#       App by PalsFreniers       #", 0x0A,
        db "###################################", 0x0A,
banner_len: equ $-banner

