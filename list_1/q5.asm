.data
pla1: .asciiz "GOTICO"
pla2: .asciiz "SRHUGO"
#a6 e a5 pontuações
#OBS uso o a5 pra somar as pontuações e salvo a do jogador 1 em a6, zero a5, somo a pontuação do jogador 2 em a5 e deixo salva la
#s2 flag
#s9 tem o valor 1 pra me ajudar um
.text
la a0, pla1 #carrega em a0 a primeira frase
la a1, pla2 #carrega em a1 a segunda frase
addi t2, zero, 0 #resultado inicialmente com o valor zero (x7)
addi s2, zero, 0 #flag para decidir qual dos loops deve ir: loop1 ou loop2
addi s9, zero, 1 #serve para comparar a flag, saber se ela é 1 ou 0
addi a5, zero, 0 #zera o a5 para contar pontos
loop1:
    lb s0, (0)a0 #carrega o caractere atual em s0
	addi a0 a0 1 #adiciona um em a0 para na proxima iteração usar o proximo caractere
	beq s0, t2, aju # se terminar a palavra pula para a função de ajuste que irá levar o programa para o segundo loop
comp:
    #daqui pra frente serve para verificar qual o caractere da frase e quantos pontos ele soma
    addi a3, zero, 65
	beq s0, a3, soma1
    addi a3, zero, 69
	beq s0, a3, soma1
    addi a3, zero, 73
	beq s0, a3, soma1
    addi a3, zero, 79
	beq s0, a3, soma1
    addi a3, zero, 85
	beq s0, a3, soma1
    addi a3, zero, 78
	beq s0, a3, soma1
    addi a3, zero, 82
	beq s0, a3, soma1
    addi a3, zero, 83
	beq s0, a3, soma1
	#
    addi a3, zero, 68
	beq s0, a3, soma2
    addi a3, zero, 71
	beq s0, a3, soma2
    addi a3, zero, 84
	beq s0, a3, soma2
	#
    addi a3, zero, 66
	beq s0, a3, soma3
    addi a3, zero, 67
	beq s0, a3, soma3
    addi a3, zero, 77
	beq s0, a3, soma3
    addi a3, zero, 80
	beq s0, a3, soma3
    #
	addi a3, zero, 70
	beq s0, a3, soma4
	addi a3, zero, 72
	beq s0, a3, soma4
	addi a3, zero, 86
	beq s0, a3, soma4
	addi a3, zero, 87
	beq s0, a3, soma4
	addi a3, zero, 89
	beq s0, a3, soma4
	#
	addi a3, zero, 75
	beq s0, a3, soma5
	#
	addi a3, zero, 74
	beq s0, a3, soma8
	addi a3, zero, 76
	beq s0, a3, soma8
	addi a3, zero, 88
	beq s0, a3, soma8
	#
	addi a3, zero, 81
	beq s0, a3, soma10
	addi a3, zero, 90
	beq s0, a3, soma10
	#verifica para qual loop deve ir aqui
	beq s2, t2, loop1
	beq s2, s9, loop2
soma1:
	#soma 1 na pontuação
    addi a5, a5, 1
	beq s2, t2, loop1
	beq s2, s9, loop2
soma2:
	#soma 2 na pontuação
    addi a5, a5, 2
	beq s2, t2, loop1
	beq s2, s9, loop2
soma3:
	#soma 3 na pontuação
    addi a5, a5, 3
	beq s2, t2, loop1
	beq s2, s9, loop2
soma4:
	#soma 4 na pontuação
    addi a5, a5, 4
	beq s2, t2, loop1
	beq s2, s9, loop2
soma5:
	#soma 5 na pontuação
    addi a5, a5, 5
	beq s2, t2, loop1
	beq s2, s9, loop2
soma8:
	#soma 5 na pontuação
    addi a5, a5, 8
	beq s2, t2, loop1
	beq s2, s9, loop2
soma10:
	#soma 10 na pontuação
    addi a5, a5, 10
	beq s2, t2, loop1
	beq s2, s9, loop2
aju:
	#salva a pontuação do primeiro jogador no a6
    addi a6, a5, 0
    #transforma a flag pra 1
	addi s2, zero,1
    #zera o a5
	addi a5, zero, 0
loop2:
    lb s0, (0)a1 #vai salvando os caracteres da segunda frase a cada iteração
	addi a1, a1, 1 #soma o a1 pra passar pro proximo caractere
	beq s0, t2, answ #se chegar no fim da string vai verificar quem ganhou
	j comp
    
answ:
	#aqui verifica quem ganhou e dependendo da resposta muda o resultado
    bgt a6, a5, ganha1
	bgt a5, a6, ganha2
	j emp #se for empate
    
ganha1:
	#jogador 1 ganhou
    addi t2, zero, 65
	j sonibleini
ganha2:
	#jogador 2 ganhou
    addi t2, zero, 66
	j sonibleini
emp:
	#empate
    addi t2, zero, 69
	j sonibleini
sonibleini:
	#fim do código
    #sonibleinensi
