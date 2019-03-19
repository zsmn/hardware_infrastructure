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
    
contar_caracteres:
	# Realiza a contagem da quantia de caracteres presentes na string #
	lb s3, (0)s1
    beq s3, a2, calcular_termos
    addi s1, s1, 1
	addi a7, a7, 1
j contar_caracteres

calcular_termos:
	div a5, a7, s4
    addi a5, a5, 1
	sub a6, a7, a5
	sub s1, s1, s5
j checar_palindromo

checar_palindromo:
	# A ideia é que 's3' tem o ponteiro no fim da string e 's6' um ponteiro no inicio #
    # dessa forma, podemos comparar as pontas e analisar mais facilmente o palindromo #
	lb s3, (0)s1
    lb s6, (0)s2
    # Caso tenha chegado no limite da string que está sendo analisada a esquerda #
	beq s9, a5, fim 
    # Caso tenha chegado no limite da string que está sendo analisada a direita #
	beq s10, a6, fim
    # Caso não sejam caracteres iguais, testam-se os casos que possam gerar a diferença #
	bne s3, s6, tratador
    
    # Adiciona +1 nos contadores de iteração #
	addi s9, s9, 1
	addi s10, s10, 1
    # Movimenta os ponteiros das strings, um para a esquerda e outro para a direita #
	sub s1, s1, s5
	addi s2, s2, 1
    
j checar_palindromo
    
tratador:
	# Armazenamos em 's7' a diferença entre os caracteres #
	sub s7, s3, s6
    # Caso a diferença seja, em módulo, 32, indica que um está em uppercase e o outro em lowercase #
	beq s7, a3, caso_lower_up
	beq s7, a4, caso_lower_up
    # Caso seja encontrado um espaço no ponteiro do registrador 's3' #
	beq s3, a3, caso_esp_s3 #caso onde s3 (direita) tem um espaco
    # Caso seja encontrado um espaço no ponteiro do registrador 's6' #
	beq s6, a3, caso_esp_s6 #caso onde s6 (esquerda) tem um espaco
    # Caso não seja nenhum dos casos acima, então realmente os caracteres são diferentes, logo não é palindromo #
	sub a0, a0, s5
j fim

caso_lower_up:
	sub s1, s1, s5
	addi s2, s2, 1
j checar_palindromo

caso_esp_s3:
	sub s1, s1, s5
	addi s10, s10, 1
j checar_palindromo
    
caso_esp_s6:
	addi s2, s2, 1
	addi, s9, s9, 1
j checar_palindromo

fim:
