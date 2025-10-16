    .section .note.GNU-stack, ""
    .text
    .global abs_value


abs_value:
    cmp $0, %rdi
    mov %rdi, %rax
    
    # jump if bigger than 0
    jge abs_done
    neg %rax 

abs_done:
    ret

power2:
    