    @ Draw Pixel subroutine (syscall)
    @
    @ Args:
    @ -> *r0: column
    @ -> *r1: row
    @ -> *r2: fill color (Half-word LSB)

.text
.global _dpx_syscall
_dpx_syscall:
    bx  lr

@ Literal Pool
vga_dma_addr: .word 0xc8000000
