    @ Write subroutine (syscall)
    @
    @ Args:
    @ -> *r0: buffer address
    @ -> *r1: count
    @ Used:
    @ -> r2: stdout_dma_addr
    @ -> r3: current loaded byte

.text
.global _write_syscall
_write_syscall:
    push {r0-r3}
    ldr  r2, stdout_dma_addr
    loop:
        ldrb r3, [r0], #0x1
        strb r3, [r2]
        subs r1, r1, #0x1
        bne  loop
    pop {r0-r3}
    bx  lr

@ Literal Pool
stdout_dma_addr: .word 0xff201000
