    .section .note.GNU-stack, ""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text

is_prime:
    # given a unsigned int check if its prime and if it is return 1


    # let rbx = 2 = i
    mov $2, %r8 

    # check if n <= 2
    cmp %rdi, %r8
    
    # jump if n <= 2
    jae is_prime_done

prime_loop:
    # check if n is not prime_loop

    mov $0, %rdx
    mov %rdi, %rax 

    # this is rdi / r8, rdx hold the remainder which we will check to see if prime
    div %r8

    # If reminader == 0 jump out and return 0
    cmp $0, %rdx
    je not_prime

    add $1, %r8

    # check jump when i == n
    cmp %rdi, %r8
    je is_prime_done

    jmp prime_loop

not_prime:
    mov $0, %rax
    ret

is_prime_done:
    mov $1, %rax
    ret

largest_power_unsigned:
    # takes a unsigned int and retursn the largest power
    mov %rdi, %rax

    # what we will multiple into rax
    mov %rdi, %rsi

largest_loop:
    # keep multilping rax until we hit overflow then we divide but rdx and return
    mul %rdi
    jno largest_loop
    div %rsi

largest_done:
    ret

overflowing_subtract:
    # rdi = a rsi = b

    mov %rdi, %rax

    sub %rsi, %rax

    # jump if overflow
    jo subtract_done
    ret

subtract_done:
    mov $0, %rax
    ret
    