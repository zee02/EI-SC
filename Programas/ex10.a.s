.data
  cr: .word 0x10000
  dr: .word 0x10008

.code
; s1, s2, s3 control data auxiliar
;

  ld $s1,cr($zero)
  ld $s2,dr($zero)

  ;obter a
  daddi $s3, $zero,8
  sd $s3,($s1)
  ld $a0,($s2)

  ;obter b
  daddi $s3, $zero,8 ; Funciona porque já tem valor 8
  sd $s3,($s1)
  ld $a1,($s2)

  ;a0 e a1
  jal Max
  ;max em v0

  sd $v0,($s2)
  daddi $s3,$zero,2
  sd $s3,($s1)

  halt

; Função Max
; valores a em a0 e b a1
; max em v0


Max:
  dadd $v0, $a0, $zero ;maior = a
  slt $t0,$a0, $a1 ;se a < b
  beqz $t0	


  dadd $v0,$a1,$zero;   maior = b

MaiorA:
  jr $ra
 

  jr $ra