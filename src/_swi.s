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

    kill_syscall:
        b after

    safekill_syscall:
        b after

    restart_syscall:
        b after

    io_syscall:
        b after

    cse_syscall:
        b after

    segfault_syscall:
        b after

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

jump_table_addr: .word jump_table
