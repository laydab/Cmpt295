    .section .note.GNU-stack,""
    .global calculate
    .text

    calculate:
        push %rbx # for x
        push %r12 # for a
        push %r13 # for b
        push %r14 # for c
        push %r15 # for d

        mov %rdi, %rbx # rbx = x
        mov %rbx, %r12
        add $3, %r12 # r12 = a = x + 3

        mov  %rbx, %rdi # arg1 = x
        mov  %r12, %rsi # arg2 = a
        call f
        mov  %rax, %r13 # b in r13

        mov  %r13, %rdi # arg1 = b
        mov  %rbx, %rsi # arg2 = x
        call f
        mov  %rax, %r14 # c in r14

        mov  %rbx, %rdi # arg1 = x
        mov  %r14, %rsi # arg2 = c
        call f
        mov  %rax, %r15 # d in r9

        mov  %r12, %rax # rax = a
        add  %r13, %rax # rax = a + b
        add  %r14, %rax # rax = a + b + c
        add  %r15,  %rax # rax = a + b + c + d

        pop  %r15
        pop  %r14
        pop  %r13
        pop  %r12
        pop  %rbx
        ret



