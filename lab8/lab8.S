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

    mov $0, %rax

hail_loop:

    # check if n == 1
    cmp $1, %rdi
    je done

    add $1, %rax
    
    # rcx = n
    mov %rdi, %rcx

    # rcx 3 * n + 1
    imul $3, %rcx
    add $1, %rcx

    # rdx = n
    mov %rdi, %rdx

    # rdx = n / 2
    shr $1, %rdx

    mov %rdi, %rsi

    # check if odd 
    and $1, %rsi

    # If odd, move rcs into rdx
    cmovnz %rcx, %rdx

    mov %rdx, %rdi
    jmp hail_loop

done:
    ret