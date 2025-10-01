    .section .note.GNU-stack, ""
    .global is_prime
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

    # increment i++
    inc %rbx

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

