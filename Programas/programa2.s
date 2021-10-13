; programa1 : troca vars
; int A=7,B=4
; troca A com B
.data
A: .word 7
B: .word 4

.code
	ld r4,A(r0)
	ld r5,B(r0)

	
	sd r4,B(r0)
	sd r5,A(r0)
	
	halt