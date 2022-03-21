		.data
i:		.word	0
C:		.word	7
A:		.space	800
B:		.space	800

		.text

	DADDI	R1,R0,0	;inicializa i 
	SD	R1, i(R0)	;armazena i 
	
loop:

	LD	R1,i(R0)	;obtem o valor de i 
	DADDI	R9,R0,8		;tamanho da dword para multiplicação pelo indice
	DMUL	R2,R1,R9	;R2 = offset de i
;6 bolhas
	LD	R4,B(R2)	;carrega o valor de B[i] 
	LD	R5,C(R0)	;carrega o valor de C 

	DADD	R6,R4,R5	;B[i]+C 
;1 bolha
	LD	R1,i(R0)	;obtem o valor de i 
	DADDI	R9,R0,8		;tamanho da dword para multiplicação pelo indice
	DMUL	R2,R1,R9	;R2 = offset de i
;6 bolhas
	SD	r6,A(r2)	;A[i] = B[i]+C 

	LD	R1,i(R0)	;obtem o valor de i 
;1 bolha
	DADDI	R1,R1,1		;incrementa i 
	SD	r1,i(R0)	;armazena i 

	LD	R1,i(R0)		;obtem o valor de i
;1 bolha
	DADDI	R8,R1,-100	;o contador chegou a 100? 
	BNEZ	R8,loop		;se não chegou, repete o ciclo 
;1 bolha de controlo
	halt			;termina a execução 
