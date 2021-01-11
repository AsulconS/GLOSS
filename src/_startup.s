.section .rodata
.global splash_screen
splash_screen: .incbin "emb/splash565.bmp"
.align

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
    @ set all registers to 0 (excepting PC)
    ldr r0, null_data_addr
    ldm r0, {r0-r12, sp, lr}
    b   _start

@ Literal Pool
null_data:      .space 0x4*0xf
null_data_addr: .word null_data

fd_start_addr:  .word fd_start
rd_start_addr:  .word rd_start
data_size_addr: .word data_size
