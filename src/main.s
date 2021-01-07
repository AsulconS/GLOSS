.data
arr: .byte 4, 8, 16
eoa: .align
res: .word 0x0

.text
.global _start
_start:
    b  main

main:
    ldr r0, arr_addr
    ldr r1, eoa_addr
    bl  arrsum
    ldr r1, res_addr
    str r0, [r1]
    svc #0x3
    ldr r2, button_state_addr
    b   main

end:
    b end

@ Literal Pool
arr_addr: .word arr
eoa_addr: .word eoa
res_addr: .word res
button_state_addr: .word button_state
