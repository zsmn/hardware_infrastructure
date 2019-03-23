#a0 = armazena o numero a ser calculado
#a1 = armazena o numero a ser calculado o fatorial
#a2 = armazena o resultado do fatorial
#a3 = armazena o valor 1 (para decrescer no fatorial)
#a4 = variavel auxiliar 
#a5 = cte. 10
#s2 = resultado final do fatorial

.data
	#numero e base na memoria
	num: .word  10
	base: .word 2
.text
#calculo do fatorial
    lw a0, num
    addi a1, zero, 10
    addi a2, zero, 1
    addi a3, zero, 1
    addi a4, zero, 0
    addi a5, zero, 10
    addi s2, zero, 0
    addi s8, zero, 0
    addi s9, zero, 0

decomposition:
    beq a0, zero, sum # caso chegue em 0, acabou o programa
    # modulo 10 #
    add a4, a4, a0
    div a0, a0, a5
    mul a0, a0, a5
    sub a1, a4, a0
    # modulo 10 #
    call call_fatorial # chama o fatorial
    div a0, a0, a5 # divide o total por 10 pra pegar o próx. termo
    addi sp, sp, -4
    sw a2, (0)sp
    addi s8, s8, 1
    #add s2, s2, a2 # salva em s2 o resultado do fatorial
    addi a2, zero, 1 # reseta o resultado do fatorial
    addi a4, zero, 0 # reseta o auxiliar
    
j decomposition

call_fatorial:
	.fatorial:
    	beq a1, zero, .retorno
        mul a2, a2, a1
        sub a1, a1, a3
    	j .fatorial   
    
	.retorno:
    	ret

sum:
	beq s8, zero, comparador
	lw s9, (0)sp
    addi sp, sp, 4
    add s2, s2, s9
    addi s8, s8, -1
    
j sum

#comparação dos resultados
comparador:
	#o unico valor necessario a partir desse ponto é o valor do fatorial salvo em s2
    add a0, zero, s2 #copia do valor original
    #load do numero e sua base da memoria
    lw a1, base
    lw t0, num
    addi t1, zero, 0
    conversor:
    	#modulo
    	div a2, a0, a1
        mul a3, a2,a1
        sub a4, a0, a3
        #deslocamento do resultado e empilhamento do numero convertido na pilha
        addi a0, a2, 0
        addi t1, t1, 1
        addi sp, sp, -4
    	sw a4, (0)sp
       	bne zero, a0,conversor
        
    addi t2, zero, 0 #temporario para o load da pilha
    addi a3, zero, 10#fator de deslocamento unir os numeros que compoe o valor
    #nesse ponto o fatorial convertido de base está na pilha
    #desempilhamento do valor já na n-esima base
    desempilha:
       	lw t2, (0)sp
        addi sp, sp, 4
        add a2, a2, t2
        addi t1, t1, -1
        beq t1, zero, comparador_final
        mul a2, a2, a3
        beq zero, zero, desempilha
   
   #comparação final para dizer se é factorion ou não
   comparador_final:
   	beq t0, a2, factorion
    addi s2, zero, 0
    beq zero, zero, fim
    factorion:
    	addi s2, zero, 1
   
   fim:	
