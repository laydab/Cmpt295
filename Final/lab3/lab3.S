    .section .note.GNU-stack, ""
    .global abs_value
    .global power2
    .global hailstone_length
    .text

abs_value:
    # takes one signed integer
    # Uses conditional branching branching to return the absolute value of the argument
    # unchaged if value is positve

    # rdi = n 
    mov %rdi, %rax
    test %rax, %rax
    jl negivte
    ret

negivte:
    neg %rax
    ret

power2:
    push %rbx
    mov $1, %rbx
    mov %rdi, %rcx

    # increment counter
    inc %rcx

loop_power:
    # move the current power to rdi
    mov %rbx, %rdi

    push %rcx
    call print_uint64
    pop %rcx

    # decrement counter
    dec %rcx

    # jumps if its equal to zero
    je power2_done

    add %rbx, %rbx
    jmp loop_power

power2_done:
    pop %rbx
    ret

hailstone_length:
    # let rdi = neg

    # let rcx be the length
    mov $0, %rcx

hailstone_loop:
    # jump out if n = 1
    cmp $1, %rdi
    je length_done

    add $1, %rcx
    
    # check if n is even  so n == 0
    test $1, %rdi
    je is_even

    # what happens if we dont meet the condition

    imul $3, %rdi
    add $1, %rdi

    jmp hailstone_loop



length_done:
    mov %rcx, %rax
    ret

is_even:
    shr $1, %rdi
    jmp hailstone_loop
