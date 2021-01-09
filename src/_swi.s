.text
.global _swi
_swi:
    @ Used registers:
    @ -> r4, r5
    @ Read Only registers:
    @ -> r0-r3 (syscall args)
    @ -> r7 (syscall register)
    @ Store used registers and lr onto the stack
    push {r4, r5, lr}

    @ r4 will load the interrupt number
    ldr r4, [lr, #-0x4]
    bic r4, r4, #0xff000000

    @ Ensure valid interrupt number (>=0x0 && <0x8)
    cmp r4, #0x8
    bge undef_interrupt

    @ Switch r0 to choose a interrupt address in r1
    ldr r5, interrupt_jmp_table_addr
    ldr r5, [r5, +r4, LSL #0x2]

    @ Branch to choosen interrupt
    mov pc, r5

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
        b after

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
        ldr r5, syscall_jmp_table_addr
        ldr r5, [r5, +r7, LSL #0x2]
        blx r5  @ Passing r0-r3 args
        b   after

    @ Default interrupt (undefined)
    undef_interrupt:
        b after

after:
    ldm sp!, {r4, r5, pc}^

@ Literal Pool
interrupt_jmp_table:
    .word kill_interrupt
    .word safekill_interrupt
    .word restart_interrupt
    .word io_interrupt
    .word cse_interrupt
    .word segfault_interrupt
    .word ge_interrupt
    .word syscall_interrupt

syscall_jmp_table:
    .word _write_syscall

interrupt_jmp_table_addr: .word interrupt_jmp_table
syscall_jmp_table_addr:   .word syscall_jmp_table
