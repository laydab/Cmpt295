    .section .note.GNU-stack, ""
    .text
    .global abs_value
    .global power2
    .global hailstone_length


abs_value:
    cmp $0, %rdi
    mov %rdi, %rax
    
    # jump if bigger than 0
    jge abs_done
    neg %rax 

abs_done:
    ret


power2:
    # using c function so we have to push and pop things
    push %rbx

    mov $1, %rbx
    
    # rdi = n
    mov %rdi, %rsi

    # counter 
    mov $0, %rcx

power_loop:

    # If rcx > n, stop
    cmp %rsi, %rcx
    ja power_done

    push %rsi
    push %rcx

    mov %rbx, %rdi
    call print_uint64

    pop %rcx
    pop %rsi

    # increases rbx by 1 and then call power loop again
    add %rbx, %rbx
    inc %rcx
    jmp power_loop

power_done:
    pop %rbx
    ret


hailstone_length:
    # let rax be the length
    mov $0, %rax


hail_loop:

    # ends loop if n == 1
    # cmp y, x
    cmp $1, %rdi
    je hail_done

    # incease length
    add $1, %rax

    # check if (n & 1) == 0
    test $1, %rdi 
    jz hail_even


    # n = 3 * n + 1
    imul $3, %rdi
    add $1, %rdi

    jmp hail_loop

hail_even:
    # n = n/2
    shr $1, %rdi
    jmp hail_loop


hail_done:
    ret
