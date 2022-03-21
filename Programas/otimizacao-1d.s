		.data
i:		.word	0
C:		.word	7
A:		.space	800
B:		.space	800

		.text
;i tem R1 atribuido
;valor 8 vai ficar reservado para o registo r9
;i = 0
	DADDI	R9,R0,8		;tamanho da dword para multiplicação pelo indice <------
	LD	R5,C(R0)	;carrega o valor de C <---
	
loop:
	LD	R4,B(R2)	;carrega o valor de B[i] <---
;1 bolha
	DADDI R8,R1, -792; <--- 800-8
	DADD	R6,R4,R5	;B[i]+C 
	SD	r6,A(r2)	;A[i] = B[i]+C <---
	
	DADDI 	R1,R1,8 ; <---
;	DADDI	R8,R1, -800
;1 bolha
	BNEZ	R8,loop		;se não chegou, repete o ciclo
	DSRA R1,R1,3; r1/8
	SD r1, i(R0); 
;1 bolha de controlo
	halt			;termina a execução 
