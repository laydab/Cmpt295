    .section .note.GNU-stack, ""
    .global hailstone_length  
    .global hailstone_length_cmov
    .text

hailstone_length:

    mov $0, %rax

loop_hail:
    
    # while n != 1
    cmp $1, %rdi

    # check if n == 1 then exit
    je hail_done

    # increment
    add $1, %rax

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


hailstone_length_cmov:
    # rdi is the val

    mov $0, %rax

hail_loop:
    # check if 1 == n and jump if so keeps looping if 1 != n
    cmp $1, %rdi
    je hailc_done

    # rsi be n 3 * n + 1
    mov %rdi, %rcx

    imul $3, %rcx
    add $1, %rcx

    # r8 will hold value if even
    mov %rdi, %r8
    # n / 2
    shr $1, %r8

    test $1, %rdi
    cmovne %rcx, %rdi
    cmove %r8, %rdi

    add $1, %rax

    jmp hail_loop

hailc_done:
    ret