.data
str: .asciiz "HELLO WORLD"

.text
addi s2, zero, 65 # (A)
addi s3, zero, 69 # (E)
addi s4, zero, 73 # (I)
addi s5, zero, 79 # (O)
addi s6, zero, 85 # (U)
addi s7, zero, 0 # (final da string)
addi a4, zero, 0 # (contador de vogais)
la a1, str # carrega no a1 a memoria inicial da string
loop:
	lb a3, (0)a1 # pega o caractere
    beq a3, s7, fim # ve se chegou no final da string
    beq a3, s2, soma # ve se eh vogal A
    beq a3, s3, soma # ve se eh vogal E
    beq a3, s4, soma # ve se eh vogal I
    beq a3, s5, soma # ve se eh vogal O
    beq a3, s6, soma # ve se eh vogal U
    j somau
soma: # incrementa a memoria de a1 e incrementa o contador de vogais
	addi a4, a4, 1
    addi a1, a1, 1
    j loop
somau: # incrementa a memoria de a1 
    addi a1, a1, 1
    j loop

fim: #FIM !!!
