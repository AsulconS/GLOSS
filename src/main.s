.data
init_color: .word 0x07e9

.text
.global _start
_start:
    b main

main:
    ldr r0, init_color_addr
    ldr r0, [r0]
    loop:
        mov r7, #0x2 @ cls    syscall
        svc #0x7     @ invoke syscall
        ror r0, r0, #0x1f
        b  loop

end:
    b end

@ Literal Pool
init_color_addr: .word init_color
