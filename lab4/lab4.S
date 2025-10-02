    .section .note.GNU-stack, ""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text

# should either return 1 if is prime or 0 if not prime
is_prime:
    # let rbx = 2 = i
    mov $2, %rbx 

    # rax = n
    mov %rdi, %rsi 


    # check if n <= 2
    cmp %rsi, %rbx
    
    # jump if n <= 2
    jae is_prime_done

loop_prime:
    # put n back into rax
    mov %rdi, %rax

    # set rdx to 0
    mov $0, %rdx

    # divide n by i
    div %rbx

    # so if remainder == 0, n is divisible by i
    test %rdx, %rdx 
    je not_prime

    # increase i by 1
    add $1, %rbx

    # compare i and n
    cmp %rbx, %rsi

    # jump if i < n keep looping
    ja loop_prime

is_prime_done:
    mov $1, %rax
    ret

not_prime:
    mov $0, %rax
    ret

# returns the largest power of n thats represent a 64-bit
largest_power_unsigned:
    # want to loop multiple times
    
    # this will be what I multiple n by
    mov %rdi, %rsi 

    # return value
    mov %rdi, %rax

loop_power:

    # multiply by new n
    mul %rsi

    # keep looping until overflow
    jno loop_power
    div %rsi

power_done:
    ret


overflowing_subtract:
    # rdi = a
    # rsi = b

    sub %rsi, %rdi

    # copy rdi to rax to return
    mov %rdi, %rax

    # will jump if overflow happens
    jo sub_overflow_done

subtract_done:
    ret

sub_overflow_done:
    mov $0, %rax
    ret


dumb:
    # rdi = a
    # rsi = b

    je b_plus_done

b_plus_done:
    add $1, %rsi
    mov %rsi, %rax
    ret 

a_done:

rec_done:

