.data
.global button_state
button_state: .word 0x0

.text
.global _swi
_swi:
    @ Used registers:
    @ -> r0, r1
    @ Read Only registers:
    @ -> r7 (syscall register)
    @ Store used registers and lr onto the stack
    push {r0, r1, lr}

    @ r0 will load the interrupt number
    ldr r0, [lr, #-0x4]
    bic r0, r0, #0xff000000

    @ Ensure valid interrupt number (>=0x0 && <0x8)
    cmp r0, #0x8
    bge undef_interrupt

    @ Switch r0 to choose a interrupt address in r1
    ldr r1, jump_table_addr
    ldr r1, [r1, +r0, LSL #0x2]

    @ Branch to choosen interrupt
    mov pc, r1

    @ 0x0 interrupt
    kill_interrupt:
        b after

    @ 0x1 interrupt
    safekill_interrupt:
        b after

    @ 0x2 interrupt
    restart_interrupt:
        b after

    @ 0x3 interrupt
    io_interrupt:
        ldr r0, button_dma_addr
        ldr r1, button_state_addr
        ldr r0, [r0]
        str r0, [r1]
        b   after

    @ 0x4 interrupt
    cse_interrupt:
        b after

    @ 0x5 interrupt
    segfault_interrupt:
        b after

    @ 0x6 interrupt
    ge_interrupt:
        b after

    @ 0x7 interrupt
    syscall_interrupt:
        b after

    @ Default interrupt (undefined)
    undef_interrupt:
        b after

after:
    ldm sp!, {r0, r1, pc}^

@ Literal Pool
jump_table:
    .word kill_interrupt
    .word safekill_interrupt
    .word restart_interrupt
    .word io_interrupt
    .word cse_interrupt
    .word segfault_interrupt
    .word ge_interrupt
    .word syscall_interrupt

jump_table_addr:   .word jump_table
button_dma_addr:   .word 0xff200050
button_state_addr: .word button_state
