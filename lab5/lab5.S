    .section .note.GNU-stack, ""
    .text
    .global fibonacci
    .global polynomial1
    .global polynomial2
    .global is_odd1
    .global is_odd2
    .global mul1

fibonacci:
    push %r8
    push %r9

    # copies n to r8
    mov %rdi, %r8

    # jumps if n <= 1
    cmp $1, %rdi
    jbe fib_done

    # fib(n-1)
    mov %r8, %rdi
    sub $1, %rdi
    call fibonacci

    # copies rax to r9
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


polynomial1:

    # x = rdi
    # a = rsi
    # b = rdx
    # c = rcx
    # d = r8

    # rax = a * x^3
    mov %rdi, %rax
    imul %rdi, %rax
    imul %rdi, %rax
    imul %rsi, %rax

    # rax = a * x^3 + b * x^2
    mov %rdi, %r9
    imul %rdi, %r9
    imul %rdx, %r9
    add %r9, %rax

    # rax = a * x^3 + b * x^2 + c * x
    mov %rdi, %r10
    imul %rcx, %r10
    add %r10, %rax

    # rax = a * x^3 + b * x^2 + c * x + d
    add %r8, %rax

    ret

polynomial2:

    # x = rdi
    # a = rsi
    # b = rdx
    # c = rcx
    # d = r8

    # (a * x + b)
    mov %rsi, %rax
    imul %rdi, %rax
    add %rdx, %rax

    # (x * (a * x + b) + c)
    imul %rdi, %rax
    add %rcx, %rax

    # x * (x * (a * x + b) + c) + d
    imul %rdi, %rax
    add %r8, %rax

    ret

is_odd1:

    # let r8 = 2
    mov $2, %r8

    mov %rdi, %rax

    # sign extends %rax into %rdx
    cqto
    idiv %r8

    # jump if remainder is 1
    cmp $1, %rdx
    je odd1_done

    # set to 0 if even
    mov $0, %rax
    ret
    

odd1_done:
    mov $1, %rax
    ret

is_odd2:
    mov %rdi, %rax

    # leaves 0 if even or 1 if 0dd
    and $1, %rax
    ret


mul1: 
    mov $65537, %rax
    mul %rdi
    ret