addi a0, zero, 5 # a = 5
addi a1, zero, 64 # b = 64
addi a2, zero, 25 # c = 25
addi a3, zero, 123 # x = 123 (um valor qualquer)
addi a4, zero, 64 # salva nesse registrador o valor de 64 para futuras comparacoes
addi a5, zero, 24 # salva nesse registrador o valor de 24 para futuras comparacoes
addi a3, zero, 0 # atualiza o valor de x para zero

bge a0, x0, comp2 #envia para comp2 se a>=0
j fin # se nao, vai para o fim

comp2:
	bge a4, a1, comp3 #envia para comp3 se b<=64
    j fin # se nao, vai para o fim
comp3:
	blt a5, a2, iguala #envia para iguala se c>24
    j fin # se nao, vai para o fim
iguala:
	addi a3, zero, 1 #alteramos o valor de x para 1 !!!
fin: # fim :) !!!!
