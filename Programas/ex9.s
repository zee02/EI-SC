data
  cr: .word 0x10000
  dr: .word 0x10008
  s:  .asciiz "ola tudo bem"
  s1: .asciiz ""

.code
;r1 r2 r3 cr dr aux
;r4 i. r5 caractere

 ld r1,cr(r0)
 ld r2,dr(r0)


;i=0
;while s[i]!=0	
;i++

 daddi r4,r0,0 ;i=0
While:
 lb r5,s(r4);  s[i]
 beqz r5, FimWhile ;while s[i]!=0
 daddi r4,r4,1 ;i++
 j While

FimWhile:
 daddi r3,r0,2
 sd r4(r2)
 sd r3,(r1)

;ler tecla
 daddi r3,r0,9
 sd r3,(r1)
 lb r5,(r2)

 daddi r5,r5,-32; converter para minuscula. Se for maiuscula é +32
 sb r5,r1(r0); string 1 na posição 0. s1[0] = tecla
 
;mostrar string no terminal
 daddi r3,r0,r1
 sd r3,(r2)
 daddi r3,r0,r4
 sd r3,(r1)	



halt