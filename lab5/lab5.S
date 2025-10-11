    .section .note.GNU-stack, ""
    .text
    .global fibonacci
    .global dumb

fibonacci:
    push %r8
    push %r9

    # copies n to r9
    mov %rdi, %r8

    # jumps if n <= 1
    cmp $1, %rdi
    jbe fib_done

    # fib(n-1)
    mov %r8, %rdi
    sub $1, %rdi
    call fibonacci

    # stores rax
    mov %rax, %r9

    # fib(n-2)    
    mov %r8, %rdi
    sub $2, %rdi
    call fibonacci

    # add fib(n-1) + fib(n-2)
    add %r9, %rax
    pop %r9
    pop %r8
    ret

fib_done:
    mov %rdi, %rax
    pop %r9
    pop %r8
    ret