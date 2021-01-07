.section "exception"
.global _entry
_entry:
reset:  b _startup
undef:  b _undef
swi:    b _swi
pf_abt: b pf_abt
dt_abt: b dt_abt
        nop
irq:    b irq
frq:    b frq
