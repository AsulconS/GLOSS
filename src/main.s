.data
init_color:    .word 0x07e9
splash_screen: .incbin "emb/img565.bmp"
.align

.text
.global _start
_start:
    b main

main:
    ldr r0, init_color_addr
    ldr r0, [r0]
    mov r7, #0x2 @ cls    syscall
    svc #0x7     @ invoke syscall

    ldr r0, splash_screen_addr
    mov r7, #0x4 @ img    syscall
    svc #0x7     @ invoke syscall

end:
    b end

@ Literal Pool
init_color_addr:    .word init_color
splash_screen_addr: .word splash_screen
