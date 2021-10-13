; programa1 : troca registos r4 e r5
; 

.code
	dadd r3,r4,r0	;r3=r4
	dadd r4,r5,r0	;r4=r5
	dadd r5,r3,r0	;r5=r3

	halt