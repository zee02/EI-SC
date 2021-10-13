; programa1 : soma
; int A=7,B=4,C;
; C=A+B+C
.data
A: .word 7
B: .word 4
C: .word 0
Z: .word 3
	.code
	ld r4,A(r0)
	ld r5,B(r0)
	ld r7,Z(r0)

	dadd r6,r4,r5
	dadd r8,r6,r7
	
	sd r8,C(r0)
	
	halt