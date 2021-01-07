    @ Arrsum subroutine (LEAF function)
    @
    @ Args:
    @ r0: Start address of array
    @ r1: End address of array
    @
    @ Result:
    @ r0: Sum of array

.text
.global arrsum
arrsum:
    @ Arg registers:
    @ -> r0, r1
    @ Modified registers (pushed):
    @ -> r2, r3
    @ Return register:
    @ -> r0
    push {r2, r3}
    mov  r3, #0x0
    loop:
        ldrb r2, [r0], #0x1
        add  r3, r3, r2
        cmp  r0, r1
        bne  loop
    mov r0, r3
    pop {r2, r3}
    bx lr
