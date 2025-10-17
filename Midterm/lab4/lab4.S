    .section .note.GNU-stack, ""
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb
    .text

is_prime:
    # rcx = i = 2
    mov $2, %rcx
    mov %rdi, %rax

loop_prime:
    # keeps looping while i < n
    # cmp rcx = i and rax = n
    cmp %rcx, %rax
    # jump if i  >= n
    jbe is_prime_done

    # copy n to r8 to save value
    mov %rax, %r8
    mov $0, %rdx
    # n % i wher n stores how many times val goes in and rdx stores remander
    div %rcx

    cmp $0, %rdx
    je not_prime

    mov %r8, %rax

    # increment i by 1
    inc %rcx

    jmp loop_prime

not_prime:
    mov $0, %rax
    ret

is_prime_done:
    mov $1, %rax
    ret

largest_power_unsigned:
    # want to keep looping until we hit overflow 
    # then divided it then return what we have

    # rax will hold the return value
    mov %rdi, %rax

    # will keep multipling rax by r8 
    mov %rdi, %r8


pow_loop:
    mul %r8
    jno pow_loop
    div %r8

pow_done:
    ret

overflowing_subtract:
    # If signed overflow happens when we do a-b then we return 0
    # rdi = a
    # rsi = b
    # a - b rdi is where it its being stores
    sub %rsi, %rdi
    jo overflow
    mov %rdi, %rax

overflow_done:
    ret

overflow:
    mov $0, %rax
    ret


dumb:
    push %rdi
    push %rsi
    # let rdi = a
    # let rsi = b


    # check if a == 0
    cmp $0, %rdi
    # jump is a == 0
    je a_zero

    # check if b == 0 then jump if so
    cmp $0, %rsi
    je b_zero

    sub $1, %rdi
    sub $1, %rsi
    call dumb

    pop %rsi
    pop %rdi

    add %rsi, %rax
    add %rdi, %rax
    add %rdi, %rax

    ret

a_zero:
    pop %rsi
    pop %rdi

    add $1, %rsi

    mov %rsi, %rax

    ret

b_zero:    
    pop %rsi
    pop %rdi
    
    mov %rdi, %rax
    ret