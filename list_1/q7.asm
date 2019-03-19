#a0 = armazena o 'r'
#a1 = armazena o 'i'
#a2 = armazena o 's'
#a3 = armazena o 'c'
#a4 = armazena o 'v'
#a5 = cte. 0
#a6 = quantas palavras "riscv" são possiveis de serem formadas

.data
  str: .asciiz "xrnrclszumskvbqchuwtgyvieip"

.text
  addi a0, zero, 0
  addi a1, zero, 0
  addi a2, zero, 0
  addi a3, zero, 0
  addi a4, zero, 0
	
  addi a5, zero, 0
  addi a6, zero, 2047
    
  addi s3, zero, 'r'
  addi s4, zero, 'i'
  addi s5, zero, 's'
  addi s6, zero, 'c'
  addi s7, zero, 'v'
    
  la s1, str
  addi s2, zero, 0

count:
  lb s2, (0)s1
  beq s2, a5, set_ans
  beq s2, s3, case_r
  beq s2, s4, case_i
  beq s2, s5, case_s
  beq s2, s6, case_c
  beq s2, s7, case_v
    
  addi s1, s1, 1
j count

case_r:
  addi a0, a0, 1
  addi s1, s1, 1
  j count
case_i:
  addi a1, a1, 1
  addi s1, s1, 1
  j count
case_s:
  addi a2, a2, 1
  addi s1, s1, 1
  j count
case_c:
  addi a3, a3, 1
  addi s1, s1, 1
  j count
case_v:
  addi a4, a4, 1
  addi s1, s1, 1
  j count

set_ans:
  blt a0, a6, set_r
  blt a1, a6, set_i
  blt a2, a6, set_s
  blt a3, a6, set_c
  blt a4, a6, set_v
    
  j fim
    
set_r:
  add a6, zero, a0
  j set_ans
set_i:
  add a6, zero, a1
  j set_ans
set_s:
  add a6, zero, a2
  j set_ans
set_c:
  add a6, zero, a3
  j set_ans
set_v:
  add a6, zero, a4
  j set_ans

fim:
