    @ Clear Screen subroutine (syscall)
    @
    @ Args:
    @ -> *r0: fill color (Half-word LSB)
    @ Used:
    @ -> r1: vga_dma_addr
    @ -> r2: i_loop boundary
    @ -> r3: j_loop boundary
    @ -> r4: row offset / offset
    @ -> r5: col offset

.text
.global _cls_syscall
_cls_syscall:
    push {r0-r5}
    ldr  r1, vga_dma_addr
    ldr  r2, vga_width_b
    i_loop:
        ldr r3, vga_height_b
        j_loop:
            lsl  r4, r3, #0xa @ 1024 bytes per row padding
            lsl  r5, r2, #0x1 @ 2    bytes per col padding
            add  r4, r4, r5
            strh r0, [r1, r4]
            subs r3, r3, #0x1
            bge  j_loop
        subs r2, r2, #0x1
        bge i_loop
    pop {r0-r5}
    bx  lr

@ Literal Pool
vga_dma_addr: .word 0xc8000000
vga_width_b:  .word 240-1
vga_height_b: .word 160-1
