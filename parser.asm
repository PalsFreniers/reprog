%include 'calls.inc'
%include 'utils.inc'
%include 'str.inc'

global _get_cmd
_get_cmd:
        mov rdi, rsi
        call _del_nl


section .data
parse_cmd_list: db "list", 0
