#a0 = armazena o numero a ser calculado o fatorial dos digitos
#a1 = auxiliar que recebe o digito a ser calculado o fatorial
#a2 = armazena o resultado do fatorial
#a3 = armazena o valor 1 (para decrescer no fatorial)
#a4 = registrador auxiliar 
#a5 = cte. 10
#s2 = resultado final
#s8 = contador de quantos numeros foram postos na stack
#s9 = registrador auxiliar

.data
    num: .word 99999

.text
    lw a0, num
    addi a1, zero, 0
    addi a2, zero, 1
    addi a3, zero, 1
    addi a4, zero, 0
    addi a5, zero, 10
    addi s2, zero, 0
    addi s8, zero, 0
    addi s9, zero, 0

decomposition:
    beq a0, zero, sum
    # Calculando o modulo 10 #
    add a4, a4, a0
    div a0, a0, a5
    mul a0, a0, a5
    sub a1, a4, a0
    # Chamada para calcular o fatorial #
    call call_fatorial
    div a0, a0, a5
    # Armazenando na stack #
    addi sp, sp, -4
    sw a2, (0)sp
    addi s8, s8, 1
    # Resetando para a proxima iteração #
    addi a2, zero, 1
    addi a4, zero, 0
    
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
    beq s8, zero, fim
    # Pegando os valores da stack e somando em 's2' #
    lw s9, (0)sp
    addi sp, sp, 4
    add s2, s2, s9
    addi s8, s8, -1
    
j sum

fim:
