    .section .note.GNU-stack, ""
    .text
    .global fibonacci
    .global dumb

# need to create another varible for rbx because the function call n twice but if we subtract 1 once, the other is already subtraced
fibonacci:
    push %r8
    push %r9

    # copies n to r9 and r8
    mov %rdi, %r9
    mov %rdi, %r8

    cmp $1, %r9
    jbe fib_done

    cmp $1, %r8
    jbe fib_done





    call fibonacci

fib_done:

    pop %rbx
    mov %rbx, %rax

    ret
