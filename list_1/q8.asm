#pseudocode

#a0 = armazena o numero a ser calculado
#a1 = armazena o numero a ser calculado o fatorial
#a2 = armazena o resultado do fatorial
#a3 = armazena o valor 1 (para decrescer no fatorial)
#s2 = resultado final

.data
	str: .asciiz "145"

.text
	la a0, str
    addi a7, zero, 0
    addi a1, zero, 0
    addi a2, zero, 1
    addi a3, zero, 1
    addi s2, zero, 0
    addi s3, zero, 48

decomposition:
    lb a1, (0)a0
    beq a1, a7, calcular_base
    sub a1, a1, s3
    call call_fatorial # chama o fatorial
    add s2, s2, a2
    addi a0, a0, 1
    addi a2, zero, 1
    
j decomposition

call_fatorial:
	.fatorial:
    	beq a1, zero, .retorno
        mul a2, a2, a1
        sub a1, a1, a3
    	j .fatorial   
    
	.retorno:
    	ret

calcular_base:
	

fim:
