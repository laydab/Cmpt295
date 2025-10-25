    .section .note.GNU-stack, ""
    .global strlen_mine
    .global strlen_utf8
    .text

strlen_mine:

    mov $0, %rax

loop_mine:
    # compares the byte at memory
    cmpb $0, (%rdi)
    je mine_done 

    # inease rax by 1 and move rdi pointer to next byte
    add $1, %rax        
    add $1, %rdi

    jmp loop_mine

mine_done:
    ret


strlen_utf8:
    mov $0, %rax

utf_loop:
    # compares the byte at memory
    cmpb $0, (%rdi)
    je utf_done

    # will check if byte is a continuation byte
    # copy byte to sil
    movb (%rdi), %sil

    # keep the last 2 bits
    andb $0b11000000, %sil

    # complare $sil to 10000000
    cmpb $0b10000000, %sil

    je skip


    add $1, %rax

skip:
    # move pointer to next byte
    add $1, %rdi
    jmp utf_loop

utf_done:
    ret
