    .section .note.GNU-stack, ""
    .global abs_value
    .global power2
    .text

abs_value:
    # takes a signed int and return abs val of arg
    # unchanged if already pos 
    # so if n is neg then we jump and convert to neg

    # let rax = n
    mov %rdi, %rax
    test %rax, %rax
    jl abs_done
    

    ret

abs_done:
    neg %rax
    ret

power2:

