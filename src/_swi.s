.text
.global _swi
_swi:
    @ Used registers:
    @ -> r0
    @ Store used registers and lr onto the stack
    push {r0, lr}

    @ r0 will load the syscall number
    ldr r0, [lr, #-0x4]
    bic r0, r0, #0xff000000

    @ Ensure valid syscall number (<0x7)
    cmp r0, #0x7
    bge undef_syscall

    @ Switch r0 to choose a syscall
    cmp r0, #0x0 @ Kill Operative System
    beq kill_syscall
    cmp r0, #0x1 @ Turn Off Operative System
    beq safekill_syscall
    cmp r0, #0x2 @ Restart Request
    beq restart_syscall
    cmp r0, #0x3 @ IO Request
    beq io_syscall
    cmp r0, #0x4 @ Critical System Error
    beq cse_syscall
    cmp r0, #0x5 @ Segmentation Fault
    beq segfault_syscall
    cmp r0, #0x6 @ Generic Error
    beq ge_syscall

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
    ldm sp!, {r0, pc}^
