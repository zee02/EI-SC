; programa1 : calculadora hyper mega avançada/pedir ao user um número
; 
.data
	cr: .word 0x10000
	dr: .word 0x10008
	
.code
	ld r1,cr(r0)
	ld r2,dr(r0)
	
	; obter valor a
	daddi r3,r0,8
	sd r3,(r1)
	ld r4,(r2)
	
	; obter valor b
	daddi r3,r0,8
	sd r3,(r1)
	ld r5,(r2)
	
	dadd r6,r4,r5
	
	; mostrar resultado
	sd r6,(r2)
	daddi r3,r0,2
	sd r3,(r1)
	
	halt