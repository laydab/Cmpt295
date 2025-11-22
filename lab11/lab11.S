    .section .note.GNU-stack, ""
    .global dot_double
    .global dot_single
    .global map_poly_double
    .global map_poly_single
    .global dot_double_vec
    .global dot_single_vec
    .global map_poly_double_vec
    .global map_poly_single_vec
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



dot_double_vec:
    vxorpd %ymm0, %ymm0, %ymm0
    mov $0, %rcx
dot_double_vec_loop:
    cmp %rdx, %rcx
    je dot_double_vec_done
    vmovupd (%rdi, %rcx, 8), %ymm1
    vmovupd (%rsi, %rcx, 8), %ymm2
    vmulpd %ymm2, %ymm1, %ymm1
    vaddpd %ymm1, %ymm0, %ymm0
    add $4, %rcx
    jmp dot_double_vec_loop
dot_double_vec_done:
    vextractf128 $1, %ymm0, %xmm1
    vaddpd %xmm1, %xmm0, %xmm0
    vhaddpd %xmm0, %xmm0, %xmm0
    ret

dot_single_vec:
    vxorps %ymm0, %ymm0, %ymm0
    mov $0, %rcx
dot_single_vec_loop:
    cmp %rdx, %rcx
    je dot_single_vec_done
    vmovups (%rdi, %rcx, 4), %ymm1
    vmovups (%rsi, %rcx, 4), %ymm2
    vmulps %ymm2, %ymm1, %ymm1
    vaddps %ymm1, %ymm0, %ymm0
    add $8, %rcx
    jmp dot_single_vec_loop
dot_single_vec_done:
    vextractf128 $1, %ymm0, %xmm1
    vaddps %xmm1, %xmm0, %xmm0
    vhaddps %xmm0, %xmm0, %xmm0
    vhaddps %xmm0, %xmm0, %xmm0
    ret

map_poly_double_vec:
    vbroadcastsd %xmm0, %ymm0
    vbroadcastsd %xmm1, %ymm1
    vbroadcastsd %xmm2, %ymm2
    vbroadcastsd %xmm3, %ymm3
    mov $0, %rcx
map_poly_double_vec_loop:
    cmp %rdx, %rcx
    je map_poly_double_vec_done
    vmovupd (%rdi, %rcx, 8), %ymm4
    vmulpd %ymm4, %ymm0, %ymm5
    vaddpd %ymm1, %ymm5, %ymm5
    vmulpd %ymm4, %ymm5, %ymm5
    vaddpd %ymm2, %ymm5, %ymm5
    vmulpd %ymm4, %ymm5, %ymm5
    vaddpd %ymm3, %ymm5, %ymm5
    vmovupd %ymm5, (%rsi, %rcx, 8)
    add $4, %rcx
    jmp map_poly_double_vec_loop
map_poly_double_vec_done:
    ret

map_poly_single_vec:
    vbroadcastss %xmm0, %ymm0
    vbroadcastss %xmm1, %ymm1
    vbroadcastss %xmm2, %ymm2
    vbroadcastss %xmm3, %ymm3
    mov $0, %rcx
map_poly_single_vec_loop:
    cmp %rdx, %rcx
    je map_poly_single_vec_done
    vmovups (%rdi, %rcx, 4), %ymm4
    vmulps %ymm4, %ymm0, %ymm5
    vaddps %ymm1, %ymm5, %ymm5
    vmulps %ymm4, %ymm5, %ymm5
    vaddps %ymm2, %ymm5, %ymm5
    vmulps %ymm4, %ymm5, %ymm5
    vaddps %ymm3, %ymm5, %ymm5
    vmovups %ymm5, (%rsi, %rcx, 4)
    add $8, %rcx
    jmp map_poly_single_vec_loop
map_poly_single_vec_done:
    ret