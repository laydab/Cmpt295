    .section .note.GNU-stack, ""
    .global abs_value
    .global power2
    .global hailstone_length
    .text

abs_value:
    # takes a signed int and return abs val of arg
    # unchanged if already pos 
    # so if n is neg then we jump and convert to neg

    # let rax = n
    mov %rdi, %rax
    test %rax, %rax
    jl abs_done
    

    ret

abs_done:
    neg %rax
    ret

power2:
    # this will store the power
    push %rbx
    mov $1, %rbx

    # let rcx counter
    mov $0, %rcx

    mov %rdi, %rsi
power_loop:
    # jump when reach the rcx > n
    cmp %rdi, %rcx
    ja power_done

    push %rcx
    push %rdi
    mov %rbx, %rdi
    call print_uint64

    pop %rdi
    pop %rcx

    inc %rcx

    add %rbx, %rbx

    jmp power_loop
power_done:
    pop %rbx
    ret



hailstone_length:
    # let rax be the length that returned
    mov $0, %rax
    mov %rdi, %r8

hail_loop:
    # jump is n == 1
    mov %rdi, %r8
    cmp $1, %r8
    je hail_done

    # increase the length
    add $1, %rax

    # check if (n & 1) == 0
    and $1, %r8
    je hail_even

    # n = 3*n + 1
    imul $3, %rdi
    add $1, %rdi

    # jump back to the loop
    jmp hail_loop

hail_done:
    ret

hail_even:
    shr $1, %rdi
    jmp hail_loop