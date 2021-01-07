.text
.global _startup
_startup:
    ldr r0, =fd_start
    ldr r1, =rd_start
    ldr r2, =data_size
    copy_data:
        ldrb r3, [r0], #0x1
        strb r3, [r1], #0x1
        subs r2, r2, #0x1
        bne  copy_data
    @ init relevant registers (startup: fp, sp, lr)
    mov fp, #0x0
    mov sp, #0x0
    mov lr, #0x0
    b _start
