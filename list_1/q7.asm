.data
    str: .asciiz "sdjkhsdkjhdkjrlksgvlakdfgnai nlgkiscvhndlkhskljjmkljjv"
 
.text
    addi a1, zero, 0 #contar r
    addi a2, zero, 0 #contar i
    addi a3, zero, 0 #contar s
    addi a4, zero, 0 #contar c
    addi a5, zero, 0 #contar v
    addi a6, zero, 0 #fim da string
    addi t0, zero, 114 # r
    addi t1, zero, 105 # i
    addi t2, zero, 115 # s
    addi t3, zero, 99  # c
    addi t4, zero, 118 # v
 
    la s1, str
    loop:
    lb s2, (0)s1
    beq s2, a6 endloop
    addi s1, s1, 1
    beq s2, t0, somar # incrementa o contador de r
    beq s2, t1, somai # incrementa o contador de i
    beq s2, t2, somas # incrementa o contador de s
    beq s2, t3, somac # incrementa o contador de c
    beq s2, t4, somav # incrementa o contador de v
    j loop
    endloop:
    addi s3, a1, 0 # assume que a1 eh o menor
    backcomp:
    blt a2, s3, mena2 #confere se a2 eh o novo minimo
    blt a3, s3, mena3 #confere se a3 eh o novo minimo
    blt a4, s3, mena4 #confere se a4 eh o novo minimo
    blt a5, s3, mena5 #confere se a5 eh o novo minimo
    j end
   
    mena2:
    addi s3, a2, 0 # atualizando o novo tamanho minimo
    j backcomp
    mena3:
    addi s3, a3, 0 # atualizando o novo tamanho minimo
    j backcomp
    mena4:
    addi s3, a4, 0 # atualizando o novo tamanho minimo
    j backcomp
    mena5:
    addi s3, a5, 0 # atualizando o novo tamanho minimo
    j backcomp
    somar:
        addi a1, a1, 1 # incrementando a1
        j loop
    somai:
        addi a2, a2, 1 # incrementando a2
        j loop
    somas:
        addi a3, a3, 1 # incrementando a3
        j loop
    somac:
        addi a4, a4, 1 # incrementando a4
        j loop
    somav: 
        addi a5, a5, 1 # incrementando a5
        j loop
   
    end:
    addi a0, s3, 0 #salva em a0 a resposa final
