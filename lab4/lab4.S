    .section .note.GNU-stack, ""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text


is_prime:
    # rax = n
    mov %rdi, %rsi 

    # let rbx = 2 = i
    mov $2, %r8 

    # check if n <= 2
    cmp %rsi, %r8
    
    # jump if n <= 2
    jae is_prime_done

loop_prime:
    # put n back into rax
    mov %rsi, %rax

    # set rdx to 0
    mov $0, %rdx

    # divide n by i
    div %r8

    # so if remainder == 0, n is divisible by i
    cmp $0, %rdx 
    je not_prime

    # increase i by 1
    add $1, %r8

    # compare i and n
    cmp %r8, %rsi

    # jump if i >=  n 
    jbe is_prime_done

    jmp loop_prime

is_prime_done:
    mov $1, %rax
    ret

not_prime:
    mov $0, %rax
    ret


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

    # this will push rdi and rsi on the stack
    push %rdi
    push %rsi

    # rdi = a
    # rsi = b

    # jumps if a == 0
    cmp $0, %rdi
    je b_plus_done

    # jumps if b == 0
    cmp $0, %rsi
    je a_done

    # decremnt rdi and rsi
    sub $1, %rdi
    sub $1, %rsi

    # calls dumb function again until condtion above is satisfied
    call dumb

    # Pop rsi and rdi from stack
    pop %rsi
    pop %rdi

    # add preserved rsi and rdi to rax
    add %rsi, %rax
    add %rdi, %rax
    add %rdi, %rax

    ret

b_plus_done:
    # Pop rsi and rdi from stack
    pop %rsi
    pop %rdi

    # add 1 to rsi then copy rsi to rax
    add $1, %rsi
    mov %rsi, %rax
    ret 

a_done:
    # Pop rsi and rdi from stack
    pop %rsi
    pop %rdi

    # copy rdi to rax
    mov %rdi, %rax
    ret


