    @ Arrsum subroutine (syscall)
    @
    @ Args:
    @ -> *r0: buffer address
    @ -> *r1: result address
    @ -> *r2: count
    @ Used:
    @ -> r3: current sum
    @ -> r4: current loaded byte

.text
.global _arrsum_syscall
_arrsum_syscall:
    push {r0-r4}
    mov  r3, #0x0
    loop:
        ldrb r4, [r0], #0x1
        add  r3, r3, r4
        subs r2, r2, #0x1
        bne  loop
    str r3, [r1]
    pop {r0-r4}
    bx  lr
