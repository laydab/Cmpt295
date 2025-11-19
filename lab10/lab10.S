    .section .note.GNU-stack, ""
    .global dot_double
    .global dot_single
    .global map_poly_double
    .global map_poly_single
    .global sin_x87
    .text

dot_double:

    xorpd %xmm0, %xmm0

    mov $0, %rcx

double_loop:
    cmp %rdx, %rcx
    je double_done

    # loads arr1[i] and arr2[i]
    movsd (%rdi, %rcx, 8), %xmm1
    movsd (%rsi, %rcx, 8), %xmm2

    mulsd %xmm2, %xmm1
    addsd %xmm1, %xmm0

    add $1, %rcx
    
    jmp double_loop

double_done:
    ret


map_poly_double:

    mov $0, %rcx

map_double_loop:
    cmp %rdx, %rcx
    je map_double_done

    # moves x = input[i]
    movsd (%rdi, %rcx, 8), %xmm4

    movsd %xmm4, %xmm5
    mulsd %xmm0, %xmm5

    # a*x + b
    addsd %xmm1, %xmm5

    # x*(a*x + b)
    mulsd %xmm4, %xmm5

    # x*(a*x + b) + c
    addsd %xmm2, %xmm5

    # x*(x*(a*x + b) + c)
    mulsd %xmm4, %xmm5

    # x*(x*(a*x + b) + c) + d
    addsd %xmm3, %xmm5

    # stores result in output[i]
    movsd %xmm5, (%rsi, %rcx, 8)

    add $1, %rcx

    jmp map_double_loop

map_double_done:
    ret
    
dot_single:

    xorps %xmm0, %xmm0

    mov $0, %rcx

dot_single_loop:

    cmp %rdx, %rcx
    je dot_single_done
    
    # loads arr1[i] and arr2[i]
    movss (%rdi, %rcx, 4), %xmm1
    movss (%rsi, %rcx, 4), %xmm2

    mulss %xmm2, %xmm1
    addss %xmm1, %xmm0

    add $1, %rcx

    jmp dot_single_loop

dot_single_done:
    ret


map_poly_single:

    mov $0, %rcx

map_single_loop:

    cmp %rdx, %rcx
    je map_single_done

    # loads x = input[i]
    movss (%rdi, %rcx, 4), %xmm4

    # a*x
    movss %xmm4, %xmm5
    mulss %xmm0, %xmm5

    # a*x + b
    addss %xmm1, %xmm5

    # x*(a*x + b)
    mulss %xmm4, %xmm5

    # x*(a*x + b) + c
    addss %xmm2, %xmm5

    # x*(x*(a*x + b) + c)
    mulss %xmm4, %xmm5

    # x*(x*(a*x + b) + c) + d
    addss %xmm3, %xmm5

    # result in output[i]
    movss %xmm5, (%rsi, %rcx, 4)

    add $1, %rcx
    
    jmp map_single_loop

map_single_done:
    ret


sin_x87:

    mov $0, %rcx

s87_loop:

    cmp %rdx, %rcx
    jae s87_ret
    fldl (%rdi, %rcx, 8)
    fsin
    fstpl (%rsi, %rcx, 8)
    inc %rcx
    jmp s87_loop

s87_ret:
    ret