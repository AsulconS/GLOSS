.data
.global button_state
button_state: .word 0x0

.text
.global _swi
_swi:
    @ Used registers:
    @ -> r0, r1
    @ Store used registers and lr onto the stack
    push {r0, r1, lr}

    @ r0 will load the syscall number
    ldr r0, [lr, #-0x4]
    bic r0, r0, #0xff000000

    @ Ensure valid syscall number (>=0x0 && <0x7)
    cmp r0, #0x7
    bge undef_syscall

    @ Switch r0 to choose a syscall address in r1
    ldr r1, jump_table_addr
    ldr r1, [r1, +r0, LSL #0x2]

    @ Branch to choosen syscall
    mov pc, r1

    @ 0x0 syscall
    kill_syscall:
        b after

    @ 0x1 syscall
    safekill_syscall:
        b after

    @ 0x2 syscall
    restart_syscall:
        b after

    @ 0x3 syscall
    io_syscall:
        ldr r0, button_dma_addr
        ldr r1, button_state_addr
        ldr r0, [r0]
        str r0, [r1]
        b   after

    @ 0x4 syscall
    cse_syscall:
        b after

    @ 0x5 syscall
    segfault_syscall:
        b after

    @ 0x6 syscall
    ge_syscall:
        b after

    undef_syscall:
        b after

after:
    ldm sp!, {r0, r1, pc}^

@ Literal Pool
jump_table:
    .word kill_syscall
    .word safekill_syscall
    .word restart_syscall
    .word io_syscall
    .word cse_syscall
    .word segfault_syscall
    .word ge_syscall

jump_table_addr:   .word jump_table
button_dma_addr:   .word 0xff200050
button_state_addr: .word button_state
