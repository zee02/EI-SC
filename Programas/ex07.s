.data
 IP: .byte 15,10,168,192 
;little endian
;192.168.10.15

 Mask25: .word32 0xFFFFFF80
 MasInv25: .word32 0x0000007F


.code
  daddi r29,r0,0x80; inicialização do endereço da pilha

; Mostrar r1 com r2 bits
;  daddi r1,r0,-3; valor a mostrar
;  daddi r2,r0,64; n bits a mostrar
;  jal Bin; chamada da rotina
 
;a)
daddi r2,r0,8; n bits a mostrar

;a1) portas 0 e 5 abertas
  daddi r1,r0,0xDE
  jal Bin

;a2) abrir porta 2
  andi r1,r1,0xFB; 1111 1011
  jal Bin

;a3) fechar porta 5
  ori r1,r1,0x20; 0010 0000
  jal Bin

;a4) alterar portas 1 e 2
  xori r1,r1,0x06; mascara 0000 0110
  jal Bin

;b) IP 192,168,10,15
 daddi r2,r0,32; n bits a mostrar
 LW r1,IP(r0)
 jal Bin

;b2) mascara/25
  lw r1,Mask25(r0)
  jal Bin

;b3) endereço de rede
;r1 IP   r8 mask -> r1 rede
  lw r1,IP(r0)
  lw r8,Mask25(r0)
  and r1,r1,r8
  jal Bin

;b4) endereço broadcast
  lw r1,IP(r0)
  lw r8,MaskInv25(r0)
  or r1,r1,r8; Não é ORI pois estamos a trabalhar com mais de 16 bits (ver b))
  halt  

  
; Função Bin
; Mostra binário com n bits e muda linha
; Recebe valor em r1 e n em r2
; n deve estar ente 1 e 64
; Utiliza 72 Bytes na pilha

Bin:
  ;r8: aux
  ;r9: control; data: 8(r9)
  ;r10: valor
  ;r11: n
  
  ; preservar a0 e a1
  daddi r10,r1,0; valor
  daddi r11,r2,0; n
  
  ; control = 0x10000
  daddi r9,r0,0x1000
  dsll r9,r9,4

  daddi r30,r29,0; âncora

  ;reserva string de 64+8 Bytes na pilha
  daddi r29,r29,-72
  
  daddi r30,r30,-1
  sb r0,(r30) ; terminador NULL

  daddi r30,r30,-1
  daddi r8,r0,0xa
  sb r8,(r30) ; muda linha

WhileBin:  
  daddi r30,r30,-1; posição anterior

  ; se múltiplo de 8 insere espaço
  dsub r8,r2,r11;
  andi r8,r8,7;
  bnez r8,NaoMultiplo8
  daddi r8,r0,32; espaço
  sb r8,(r30); espaço
  daddi r30,r30,-1; posição anterior
NaoMultiplo8:    
  
  andi r8,r10,1; aplica máscara ...00001
  daddi r8,r8,48 ; obtém caracter '0'/'1'
  sb r8,(r30); '0' ou '1'
  
  dsrl r10,r10,1; retira lsb
  daddi r11,r11,-1; n--
  
  bnez r11,WhileBin ; n>0?
  
  ; Mostra string com o binário
  sd r30,8(r9); data
  daddi r8,r0,4
  sd r8,(r9); control

  ; Muda linha

  ; Liberta string da pilha
  daddi r29,r29,72
  
  
  jr r31