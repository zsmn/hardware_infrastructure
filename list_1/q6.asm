#a0 = armazena o numero a ser calculado
#a1 = armazena o numero a ser calculado o fatorial
#a2 = armazena o resultado do fatorial
#a3 = armazena o valor 1 (para decrescer no fatorial)
#a4 = variavel auxiliar 
#a5 = cte. 10
#s2 = resultado final

.text
    addi a0, zero, 1234
    addi a1, zero, 10
    addi a2, zero, 1
    addi a3, zero, 1
    addi a4, zero, 0
    addi a5, zero, 10
    addi s2, zero, 0

decomposition:
    beq a0, zero, fim # caso chegue em 0, acabou o programa
    # modulo 10 #
    add a4, a4, a0
    div a0, a0, a5
    mul a0, a0, a5
    sub a1, a4, a0
    # modulo 10 #
    call call_fatorial # chama o fatorial
    div a0, a0, a5 # divide o total por 10 pra pegar o próx. termo
    add s2, s2, a2 # salva em s2 o resultado do fatorial
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

fim:
