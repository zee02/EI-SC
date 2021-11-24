; programa1 : jogo adivinha
; 
.data
	cr: .word 0x10000
	dr: .word 0x10008
	MensJog1: .asciiz "Jog1, segredo: "
	MensJog2: .asciiz "Jog2, tenta: "
	MensCerto: .asciiz "Certo!"
	MensSegMaior: .asciiz "Mais!"
	MensSegMenor: .asciiz "Menos!"
.code
;r1 cr r2 dr r3 aux
; r4 segredo r5 tentativa

	ld r1,cr(r0)
	ld r2,dr(r0)
	
	;mostrar mens pedir segredo
	daddi r3,r0,MensJog1
	sd r3,(r2)
	daddi r3,r0,4
	sd r3,(r1)
	
	; obter segredo
	daddi r3,r0,8
	sd r3,(r1)
	ld r4,(r2)
	
	;apagar ecrã
	dado r3,r0,6
	sd 6 r3,(r1)

	repete:
	;mostrar mens pedir tentativa
	daddi r3,r0,MensJog2
	sd r3,(r2)
	daddi r3,r0,4
	sd r3,(r1)

	; obter tentativa
	daddi r3,r0,8
	sd r3,(r1)
	ld r5,(r2)

	bem r4,r5,Iguais
	; se iguais salta para Iguais

	;Dica
	se xxx salta para Menos
	slt r3,r4,r5
	bne r3, Menos

	;mostrar mais!
	daddi r3,r0,MensSegMaior
	sd r3,(r2)
	daddi r3,r0,4
	sd r3,(r1)
	j FimElse

	Menos: 
	; mostrar Menos1
	daddi r3,r0,MensSegMenor
	sd r3,(r2)
	daddi r3,r0,4
	sd r3,(r1)
	FimElse:

	Iguais:

	;salta se r4 Dif r5 repete
	bne r4,r5,repete

	;mostrar mens parabéns
	daddi r3,r0,MensCerto
	sd r3,(r2)
	daddi r3,r0,4
	sd r3,(r1)
		
	
	halt