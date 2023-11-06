global _strcmp
_strcmp:
    xor rax, rax   
.loop:
    mov al, [rdi]  
    mov cl, [rsi]  
    cmp al, cl     
    jne .not_equal 
    test al, al    
    jz .equal      
    test cl, cl    
    jz .equal       
    inc rdi         
    inc rsi         
    jmp .loop        

.equal:
    mov rax, 1       
    ret

.not_equal:
    xor rax, rax     
    ret

global _del_nl
_del_nl:
    xor rax, rax      
    xor rcx, rcx      
.loop:
    mov al, [rdi]     
    test al, al       
    jz .done          
    cmp al, 10        
    jnz .not_newline  
    mov byte [rdi], 0 
    mov rax, 1        
.done:
    ret

.not_newline:
    inc rdi
    inc rcx
    cmp rcx, 255
    jae .done
    jmp .loop
