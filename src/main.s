.data
arr: .byte 4, 8, 16
.align
arr_size: .word 0x3
res: .word 0x0
hello_world: .asciz "Hello, World!\n"
.align
hello_world_size: .word 0xe

.text
.global _start
_start:
    b  main

main:
    ldr r0, arr_addr
    ldr r1, res_addr
    ldr r2, arr_size_addr
    ldr r2, [r2]
    mov r7, #0x1 @ arrsum syscall
    svc #0x7     @ invoke syscall

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
arr_size_addr: .word arr_size
res_addr: .word res

hello_world_addr:      .word hello_world
hello_world_size_addr: .word hello_world_size
