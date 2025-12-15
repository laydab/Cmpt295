    .section .note.GNU-stack, ""
    .text
    .global polynomial1
    .global polynomial2
    .global is_odd1
    .global is_odd2
    .global mul1
    .global mul2


polynomial1:
    # let rdi = x
    # let rsi = a
    # let rdx = = b
    # let rcx = c
    # let r8 = d

    imul %rdi, %rsi
    imul %rdi, %rsi
    imul %rdi, %rsi

    mov %rsi, %rax

    imul %rdi, %rdx
    imul %rdi, %rdx

    add %rdx, %rax

    imul %rdi, %rcx

    add %rcx, %rax

    add %r8, %rax

    ret
