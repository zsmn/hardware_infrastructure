#comentar dps

.data
str: .asciiz "lUzAZu  L"

.text
	addi a0, zero, 1
  addi a1, zero, 0
  addi a2, zero, 0
  addi a3, zero, 32
  addi a4, zero, -32
	addi a7, zero, 0
    
  addi s4, zero, 2
  addi s5, zero, 1  
    
  la s1, str
  la s2, str
    
contarcaracteres:
	lb s3, (0)s1
  beq s3, a2, check_palindrome # se for igual ao fim da str, manda pra o check_palindrome
  addi s1, s1, 1 # mover o cursor pelos caracteres da str
  addi a7, a7, 1
  j contarcaracteres

check_palindrome:
	div a5, a7, s4
  addi a5, a5, 1
  sub a6, a7, a5
  sub s1, s1, s5
  j brincadeira

brincadeira:
	lb s3, (0)s1 #s3 ta começando de trás
  lb s6, (0)s2 #s6 ta na frente
  beq s9, a5, fim
  beq s10, a6, fim
	bne s3, s6, tratador
    
  addi s9, s9, 1
  addi s10, s10, 1
    
  sub s1, s1, s5
  addi s2, s2, 1
    
  j brincadeira
    
tratador:
	sub s7, s3, s6
  beq s7, a3, caso1 #caso onde s3 é maiusculo e s6 eh minusculo
  beq s7, a4, caso1 #caso onde s3 é minusculo e s6 eh maiusculo
  beq s3, a3, caso2 #caso onde s3 (direita) tem um espaco
  beq s6, a3, caso3 #caso onde s6 (esquerda) tem um espaco
  sub a0, a0, s5
  j fim

caso1:
	sub s1, s1, s5
  addi s2, s2, 1
  j brincadeira

caso2:
	sub s1, s1, s5
  addi s10, s10, 1
  j brincadeira
    
caso3:
  addi s2, s2, 1
  addi, s9, s9, 1
  j brincadeira

fim:
