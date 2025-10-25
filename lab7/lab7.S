    .section .note.GNU-stack, ""
    .global randint
    .global fill_array
    .global dot
    .global dot_struct
    .data
    seed:   .quad 1
    .text

randint:
    movabs $6364136223846793005, %r8

    # loads the seed into rax
    mov seed(%rip), %rax

    # muliples rax by large constant
    imul %r8, %rax
    add $1, %rax

    # stores the value back
    mov %rax, seed(%rip)

    shr $33, %rax

    ret


fill_array:
    push %rbx
    push %r12

    mov %rdi, %rbx
    mov %rsi, %r12
    
    mov $0, %rcx

arr_loop:
    # jump if i = n
    cmp %r12, %rcx
    je arr_done

    push %rcx
    call randint

    and $0xff, %rax
    sub $128, %rax

    pop %r8

    # arr[i] = val
    mov %rax, (%rbx, %rcx, 8)

    add $1, %rcx
    jmp arr_loop

arr_done:
    pop %r12
    pop %rbx
    ret


dot:
    # rdi = arr1
    # rsi = arr2
    # rdx = n 

    mov $0, %rax

    # i = 0
    mov $0, %rcx

dot_loop:
    # jumps if i == n 
    cmp %rdx, %rcx
    je dot_done

    # arr1[i] val and arr2[i] val
    mov (%rdi, %rcx, 8), %r8
    mov (%rsi, %rcx, 8), %r9

    # multiples the value then adds it together
    imul %r9, %r8
    add %r8, %rax

    add $1, %rcx
    jmp dot_loop

dot_done:
    ret


dot_struct:
    # rdi = arr1
    # rsi = n

    mov $0, %rax

    # i = 0
    mov $0, %rcx

struct_loop:
    cmp %rsi, %rcx
    je struct_done

    mov %rcx, %r8
    shl $4, %r8

    # loads first val in a then secound val in b
    mov (%rdi, %r8), %r9
    mov 8(%rdi, %r8), %r10

    # multiples the value then adds it together
    imul %r10, %r9
    add %r9, %rax

    add $1, %rcx
    jmp struct_loop

struct_done:
    ret