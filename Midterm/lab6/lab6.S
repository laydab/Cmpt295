    .section .note.GNU-stack, ""
    .global strlen_mine
    .global strlen_utf8
    .text

strlen_mine:
    mov $0, %rax
loop_mine:

    # check if byte at memory is 0
    cmpb $0, (%rdi)
    je done_mine

    add $1, %rax
    add $1, %rdi


    jmp loop_mine

done_mine:
    ret

strlen_utf8:

    mov $0, %rax

utf_loop:
    cmpb $0, (%rdi)
    je utf_done

    testb $0b11000000, (%rdi)
    cmpb $0b10000000, (%rdi)

    je skip

    add $1, %rax

skip:
    add $1, %rdi
    jmp utf_loop

utf_done:
    ret