    .section .note.GNU-stack, ""
    .global abs_value
    .text

abs_value:
    # Steps to how to do it 
    # given the assigned interger
    # we must determine if its postive
        # and if so we leave
    # or if its negitive we make it a postive value
    # we then return the result of it
    mov %rdi, %rax
    cmp $0, %rax
    jge done
    neg %rax

done:
    ret

power2:
    # takes an unisgned interger argument (n)
    # uses print_uint64 from helpers.c
    # print the pwoer of 2 to the value 
    # so if the input is 2 the output is 
    # 1 
    # 2
    # 4
    # it always starts at 1