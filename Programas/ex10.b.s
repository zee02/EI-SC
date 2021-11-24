.data
  cr: .word 0x10000
  dr: .word 0x10008

.code
; s1, s2, s3 control data auxiliar
; s4,s5  A e B

  ld $s1,cr($zero)
  ld $s2,dr($zero)
  daddi $sp, $zero, 0x200

  ;obter a
  daddi $s3, $zero,8
  sd $s3,($s1)
  ld $s4,($s2); <--

  ;obter b
  daddi $s3, $zero,8 ; Funciona porque já tem valor 8
  sd $s3,($s1)
  ld $s5,($s2); <--

  ;a e b na pilha
  daddi $sp,$sp,-16; 2x8
  sd $s4,($sp)
  sd $s5,8($sp)

  jal Max
  ;max em v0

  ;libertar A e B da pilha
  daddi $sp,$sp,16

  sd $v0,($s2)
  daddi $s3,$zero,2
  sd $s3,($s1)

  halt

; Função Max
; valores a em a0 e b a1
; max em v0

;a $t1 b $t2
;$t0 auxiliar
Max:

  daddi $fp, $sp,0; âncora
  ld $t1,($fp) ;a. <--
  ld $t2,8($fp) ;b <--
  
  ;reservar i
  daddi $sp,$sp,-8

  ;salvaguarda $s1 e $s2
  
  daddi $sp,$sp,-16
  sd $t1,($sp)
  sd $t2,8($sp)

  daddi $s1, $zero ,0xBAD1
  daddi $s2, $zero ,0xBAD2

  ;i=6
  daddi $t0,$t0,6
  sd $t0,-8($fp)

  ;i++
  ld $t0, -8($fp)
  daddi $t0,$t0,1
  sd $t0,-8($fp)

  dadd $v0,$t1,$zero;   maior = a
  
  ;se a < b
  slt $t0,$t1,$t2 ;se a < b
  beqz $t0, MaiorA	

MaiorA:

  ;restaurar $s1 e $s2
  ld $s1,8($sp)
  ld $s2,($sp)
  daddi $sp,$sp,16
  
  ;libertar variavel i
  daddi $sp,$sp-8


  jr $ra