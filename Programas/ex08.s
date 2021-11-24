data
  cr: .word 0x10000
  dr: .word 0x10008
;declarar vetor
  v: .word 3, 15, 100, 7
     .word 0xf9876543987625aa
     .word 17, 5, 15, -100, 2023	
.code
;r1 r2 r3 cr dr aux

 ld r1,cr(r0)
 ld r2,dr(r0)

a3) 4º elemento ++
 daddi r9,0,24
 ld r3,v(r9);  3*8
 daddi r3,r3,1
 sd r3,v(r9)

;for i=0;i<10;i++
;printf(v[i])
;r5 i

 daddi r5,r0,0; i=0
 slti r3,r5,10; i<10
 beqz r3,FimFor;acaba o for se o numero for menor que 10

;mostrar primeiro elemento vetor
 ld r3,v(r0)
 sd r3,(r2)
 daddi r3,r0,2
 sd r3,(r1)

;mostrar segundo elemento vetor
 daddi r4,r0,8
 daddi r8,r0,8
For:
 ld r3,v(r4)
 sd r3,(r2)
 daddi r3,r0,2
 sd r3,(r1)

;mostrar 9º elemento vetor
 daddi r5,r0,72 ;9x8 = 72
 ld r3,v(r5)
 sd r3,(r2)
 daddi r3,r0,2
 sd r3,(r1)

;mostrar elemento i (Não usar numeros pois mips nao suporta dmul(i))
 dmul r4,r5,r8;i*8
 ld r3,v(r4)
 sd r3,(r2)
 daddi r3,r0,2
 sd r3,(r1)

;mostra 15 vezes o valor, faz o mesmo que i++. 
 daddi r5,r5,1 ;i++
 j For;Passa para o for em cima

FimFor:

halt