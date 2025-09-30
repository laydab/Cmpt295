    .section .note.GNU-stack, ""
    .global abs_value
    .global power2
    .global hailstone_length
    .text

abs_value:
    mov %rdi, %rax

    # compare n with 0
    cmp $0, %rax

    # If n >= 0, will skip negation
    jge abs_done
    neg %rax

abs_done:
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

    # rbx is length counter
    mov $0, %rax

loop_hail:
    
    # while n != 1
    cmp $1, %rdi

    # check if n == 1 then exit
    je hail_done

    # increment
    inc %rax

    # check if n is even
    mov %rdi, %rcx

    # rcx = n and 1
    and $1, %rcx

    # check if rcx == 0
    jz even

odd:
    # n = 3 * n
    imul $3, %rdi, %rdi

    # n = n + 1
    add $1, %rdi

    jmp loop_hail

even:
    # n = n/2
    shr $1, %rdi
    jmp loop_hail

hail_done:
    ret
