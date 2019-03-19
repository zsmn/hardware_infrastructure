.data
pla1: .asciiz "DA COR AZUL"
pla2: .asciiz "NA BOCA E NA PORTA DO CEU"
#a6 e a7 results
#s2 flag
#s9 um
.text
la a0, pla1
la a1, pla2
addi t2, zero, 0 #resultado
addi s2, zero, 0
addi s9, zero, 1
loop1:
	lb s0, (0)a0
    addi a0 a0 1
    beq s0, t2, aju
   #lb s1, (0)a1
comp:
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
    beq s2, t2, loop1
    beq s2, s9, loop2
soma1:
	addi a5, a5, 1
    beq s2, t2, loop1
    beq s2, s9, loop2
soma2:
	addi a5, a5, 2
    beq s2, t2, loop1
    beq s2, s9, loop2
soma3:
	addi a5, a5, 3
    beq s2, t2, loop1
    beq s2, s9, loop2
soma4:
	addi a5, a5, 4
    beq s2, t2, loop1
    beq s2, s9, loop2
soma5:
	addi a5, a5, 5
    beq s2, t2, loop1
    beq s2, s9, loop2
soma8:
	addi a5, a5, 8
    beq s2, t2, loop1
    beq s2, s9, loop2
soma10:
	addi a5, a5, 10
    beq s2, t2, loop1
    beq s2, s9, loop2
aju:
	addi a6, a5, 0
    addi s2, zero,1
    addi a5, zero, 0
loop2:
	lb s0, (0)a1
    addi a1, a1, 1
    beq s0, t2, answ
    j comp
    
answ:
	bgt a6, a5, ganha1
    bgt a5, a6, ganha2
    j emp
    
ganha1:
	addi t2, zero, 65
    j sonibleini
ganha2:
	addi t2, zero, 66
    j sonibleini
emp:
	addi t2, zero, 69
    j sonibleini
sonibleini:
	#sonibleinensi
