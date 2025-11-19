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

    mov seed(%rip), %rax

    imul %r8, %rax
    add $1, %rax

    mov %rax, seed(%rip)

    shr $33, %rax


    ret

# void fill_array(int64_t* array, uint64_t length);
fill_array:
    push %rbx
    push %r12

    # rdi is array1 and rsi being the length
    mov $0, %rcx

    # array pointer
    mov %rdi, %rbx

    # array length
    mov %rsi, %r12

fill_loop:
    # jump if rbx == rcx
    cmp %r12, %rcx
    je fill_done

    push %rcx
    # finds a random digit
    call randint
    pop %rcx

    # keep the range smaller
    and $0xff, %rax
    sub $128, %rax

    mov %rax, (%rbx, %rcx, 8)
    add $1, %rcx

    jmp fill_loop

fill_done:
    pop %r12
    pop %rbx
    ret

# int64_t dot(int64_t* arr1, int64_t* arr2, uint64_t n);
dot:
    # rdi is first array rsi is secound array and rdx is length

    mov $0, %rcx
    mov $0, %rax

dot_loop:
    cmp %rdx, %rcx
    je dot_return

    mov (%rdi, %rcx, 8), %r8

    mov (%rsi, %rcx, 8), %r9

    imul %r8, %r9
    add %r9, %rax


    add $1, %rcx

    jmp dot_loop

dot_return:
    ret


# int64_t dot_struct(pair64_t* pairs, uint64_t n);
dot_struct:
        # rdi is first array rsi is length

    mov $0, %rcx
    mov $0, %rax

struct_loop:
    cmp %rsi, %rcx
    je struct_done

    mov (%rdi), %r8 # arr[][a]
    mov 8(%rdi), %r9 

    imul %r8, %r9

    add %r9, %rax


    add $16, %rdi

    add $1, %rcx

    jmp struct_loop

struct_done:
    ret