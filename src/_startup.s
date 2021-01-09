.text
.global _startup
_startup:
    ldr r0, fd_start_addr
    ldr r1, rd_start_addr
    ldr r2, data_size_addr
    copy_data:
        ldrb r3, [r0], #0x1
        strb r3, [r1], #0x1
        subs r2, r2, #0x1
        bne  copy_data
    @ init relevant registers (startup: fp, sp, lr)
    mov fp, #0x0
    mov sp, #0x0
    mov lr, #0x0
    b   _start

@ Literal Pool
fd_start_addr:  .word fd_start
rd_start_addr:  .word rd_start
data_size_addr: .word data_size
