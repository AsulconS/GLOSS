.data
arr: .byte 4, 8, 16
eoa: .align
res: .word 0x0

hello_world: .asciz "Hello, World!\n"
.align
hello_world_size: .word .-hello_world

.text
.global _start
_start:
    b  main

main:
    ldr r0, arr_addr
    ldr r1, eoa_addr
    bl  arrsum
    ldr r1, res_addr
    str r0, [r1]

    ldr r0, hello_world_addr
    ldr r1, hello_world_size_addr
    ldr r1, [r1]
    mov r7, #0x0 @ write  syscall
    svc #0x7     @ invoke syscall
    @b   main

end:
    b end

@ Literal Pool
arr_addr: .word arr
eoa_addr: .word eoa
res_addr: .word res

hello_world_addr:      .word hello_world
hello_world_size_addr: .word hello_world_size
