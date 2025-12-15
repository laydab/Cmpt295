    .section .note.GNU-stack, ""
    .global randint
    .global fill_array
    .global dot
    .global dot_struct
    .data
    seed:   .quad 1
    .text

randint:
    movabs $6364136223846793005, %r8

    # loads the seed into rax
    mov seed(%rip), %rax

    # muliples rax by large constant
    imul %r8, %rax
    add $1, %rax

    # stores the value back
    mov %rax, seed(%rip)

    shr $33, %rax

    ret

fill_array:
    
