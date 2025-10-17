    .section .note.GNU-stack, ""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text

is_prime:
    # let rcx = i
    mov $2, %rcx

    # might check if i >= n if so its prime
    cmp %rcx, %rdi
    jbe prime_done

loop_prime:


    mov %rdi, %rax
    mov $0, %rdx
    div %rcx

    # check if rdx is zero and if so jump to prime_done
    cmp $0, %rdx
    je not_prime_done

    # increase i by 1
    add $1, %rcx

    # keep looping if i < n
    cmp %rcx, %rdi
    ja loop_prime


# return 1 if prime
prime_done:
    mov $1, %rax
    ret

# Return 0 for not prime
not_prime_done:
    mov $0, %rax
    ret


largest_power_unsigned:
    mov %rdi, %rax

    # will multiple %rax by this
    mov %rdi, %r8

large_loop:

    mul %r8

    # want to keep looping if we dont get overflow
    jno large_loop

    # If overflow comes down
    div %r8

large_done:
    ret

overflowing_subtract:
    mov %rdi, %rax
    sub %rsi, %rax
    # If overflow happens jump and return 0
    jo overflow

    ret

overflow:
    mov $0, %rax
    ret


dumb:
    push %rdi
    push %rsi
    # let rdi = a
    # let rsi = b

    # If rdi == 0
    cmp $0, %rdi
    je a_zero

    # If rsi == 0
    cmp $0, %rsi
    je b_zero

    # decreasing rdi and rsi
    sub $1, %rdi
    sub $1, %rsi

    # call dumb again
    call dumb

    pop %rsi
    pop %rdi

    add %rdi, %rax
    add %rdi, %rax
    add %rsi, %rax

    ret

a_zero:
    pop %rsi
    pop %rdi
    
    # add 1 to b then add it to rax
    add $1, %rsi
    mov %rsi, %rax

    ret

b_zero:
    pop %rsi
    pop %rdi

    # add a to rax
    mov %rdi, %rax

    ret


