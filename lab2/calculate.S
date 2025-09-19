    .section .note.GNU-stack,""
    .global calculate
    .text

    calculate:
        push %rbx
        push %r12

        mov %rdi, %rbx # rbx = x
        mov %rbx, %r12
        add $3, %r12 # r12 = a = 3

        mov  %rbx, %rdi     # arg1 = x
        mov  %r12, %rsi     # arg2 = a
        call f
        mov  %rax, %r10     # b in r10

        mov  %r10, %rdi     # arg1 = b
        mov  %rbx, %rsi     # arg2 = x
        call f
        mov  %rax, %r11     # c in r11

        mov  %rbx, %rdi     # arg1 = x
        mov  %r11, %rsi     # arg2 = c
        call f
        mov  %rax, %r9      # d in r9

        mov  %r12, %rax     # rax = a
        add  %r10, %rax     # b + a
        add  %r11, %rax     # c + a
        add  %r9,  %rax     # c + a

        pop  %r12
        pop  %rbx
        ret



