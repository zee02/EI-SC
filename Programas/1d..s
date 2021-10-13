; programa1 : soma
; int A=7,B=4,C;
; C==A+B
.data
A: .word 7
B: .word 4
C: .word 0
.code
	ld r4,A(r0)
	ld r5,B(r0)
	dadd r6,r4,r5
	sd r6,C(r0)
	
	halt