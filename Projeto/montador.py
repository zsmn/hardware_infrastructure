def binary_repr(n, bits):
    s = bin(n & int("1" * bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

arq = open('instructions.txt', 'r')
arq2 = open('instructions.mif', 'w')

group = arq.read()
arrayInst = group.split("\n")

get_bin = lambda x, n: format(x, 'b').zfill(n)

toWrite = []
toWrite.append('WIDTH = 8;\nDEPTH = 256;\n\nADDRESS_RADIX = DEC;\nDATA_RADIX = BIN;\n\nCONTENT\n\nBEGIN\n')

numberLine = '0'.zfill(3)
decod = ''

count = 0;

for x in arrayInst:
	inst = x.split(" ")
	decod=''
	#R-type
	if(inst[0] == "add"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		rs2= int(inst[1].split(",")[2].split("x")[1])

		decod= decod + '0000000'
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=get_bin(rd,5)
		decod+='0110011'

	if(inst[0] == "sub"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		rs2= int(inst[1].split(",")[2].split("x")[1])

		decod= decod + '0100000'
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=get_bin(rd,5)
		decod+='0110011'

	if(inst[0] == "and"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		rs2= int(inst[1].split(",")[2].split("x")[1])

		decod= decod + '0000000'
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='111'
		decod+=get_bin(rd,5)
		decod+='0110011'

	if(inst[0] == "slt"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		rs2= int(inst[1].split(",")[2].split("x")[1])

		decod+= '0000000'
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='010'
		decod+=get_bin(rd,5)
		decod+='0110011'

	#I-type
	if(inst[0] == "addi"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod= decod + binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=get_bin(rd,5)
		decod+='0010011'

	if(inst[0] == "srli"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod+='0000000'
		decod+=get_bin(imm,5)
		decod+=get_bin(rs1,5)
		decod+='101'
		decod+=get_bin(rd,5)
		decod+='0010011'

	if(inst[0] == "srai"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod+='0100000'
		decod+=get_bin(imm,5)
		decod+=get_bin(rs1,5)
		decod+='101'
		decod+=get_bin(rd,5)
		decod+='0010011'	

	if(inst[0] == "slli"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod+='0000000'
		decod+=get_bin(imm,5)
		decod+=get_bin(rs1,5)
		decod+='001'
		decod+=get_bin(rd,5)
		decod+='0010011'	

	if(inst[0] == "slti"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='010'
		decod+=get_bin(rd,5)
		decod+='0010011'

	if(inst[0] == "jalr"):
		rs1= int(inst[1].split(",")[1].split("x")[1])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=get_bin(rd,5)
		decod+='1100111'

	if(inst[0] == "ld"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='011'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "lw"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='010'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "lbu"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='100'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "lhu"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='101'
		decod+=get_bin(rd,5)
		decod+='0000011'
	
	if(inst[0] == "lwu"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='110'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "lh"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='001'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "lb"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		decod+=binary_repr(imm,12)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=get_bin(rd,5)
		decod+='0000011'

	if(inst[0] == "nop"):

		decod+='000000000000'	
		decod+='00000'
		decod+='000'
		decod+='00000'
		decod+='0010011'

	if(inst[0] == "break"):

		decod+='000000000001'	
		decod+='00000'
		decod+='000'
		decod+='00000'
		decod+='1110011'

	#S-type
	if(inst[0] == "sd"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rs2= int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		imm1 = binary_repr(imm,12)[0:7]
		imm2 = binary_repr(imm,12)[7:12]

		decod+=imm1
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='111'
		decod+=imm2
		decod+='0100011'

	if(inst[0] == "sw"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rs2= int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		imm1= binary_repr(imm,12)[0:7]
		imm2 = binary_repr(imm,12)[7:12]


		decod+=imm1
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='010'
		decod+=imm2
		decod+='0100011'

	if(inst[0] == "sh"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rs2= int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		imm1= binary_repr(imm,12)[0:7]
		imm2 = binary_repr(imm,12)[7:12]


		decod+=imm1
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='001'
		decod+=imm2
		decod+='0100011'

	if(inst[0] == "sb"):
		rs1= int(inst[1].split(",")[1].split("(x")[1].split(")")[0])
		rs2= int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1].split("(")[0])

		imm1= binary_repr(imm,12)[0:7]
		imm2 = binary_repr(imm,12)[7:12]


		decod+=imm1
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=imm2
		decod+='0100011'

	#SB-type
	if(inst[0] == "beq"):
		rs2= int(inst[1].split(",")[1].split("x")[1])
		rs1 = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		
		imm1 = binary_repr(imm,12)[0]
		imm2 = binary_repr(imm,12)[2:8]
		imm3 = binary_repr(imm,12)[8:12]
		imm4 = binary_repr(imm,12)[1]

		decod+=imm1+imm2
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='000'
		decod+=imm3+imm4
		decod+='1100011'

	if(inst[0] == "bne"):
		rs2= int(inst[1].split(",")[1].split("x")[1])
		rs1 = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])
		
	
		imm1 = binary_repr(imm,12)[0]
		imm2 = binary_repr(imm,12)[2:8]
		imm3 = binary_repr(imm,12)[8:12]
		imm4 = binary_repr(imm,12)[1]

		decod+=imm1+imm2
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='001'
		decod+=imm3+imm4
		decod+='1100111'

	if(inst[0] == "blt"):
		rs2= int(inst[1].split(",")[1].split("x")[1])
		rs1 = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		imm1 = binary_repr(imm,12)[0]
		imm2 = binary_repr(imm,12)[2:8]
		imm3 = binary_repr(imm,12)[8:12]
		imm4 = binary_repr(imm,12)[1]

		decod+=imm1+imm2
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='100'
		decod+=imm3+imm4
		decod+='1100111'

	if(inst[0] == "bge"):
		rs2= int(inst[1].split(",")[1].split("x")[1])
		rs1 = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[2])

		imm1 = binary_repr(imm,12)[0]
		imm2 = binary_repr(imm,12)[2:8]
		imm3 = binary_repr(imm,12)[8:12]
		imm4 = binary_repr(imm,12)[1]

		decod+=imm1+imm2
		decod+=get_bin(rs2,5)
		decod+=get_bin(rs1,5)
		decod+='101'
		decod+=imm3+imm4
		decod+='1100111'

	#UJ-Type

	if(inst[0] == "jal"):
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1])

		imm1 = binary_repr(imm,20)[0]
		imm2 = binary_repr(imm,20)[1:9]
		imm3 = binary_repr(imm,20)[10]
		imm4 = binary_repr(imm,20)[10:20]


		decod+=imm1+imm4+imm3+imm2
		decod+=get_bin(rd,5)
		decod+='1101111'

	#U-Type

	if(inst[0] == "lui"):
		rd = int(inst[1].split(",")[0].split("x")[1])
		imm= int(inst[1].split(",")[1])

		decod+=binary_repr(imm,20)
		decod+=get_bin(rd,5)
		decod+='0110111'


	if(len(x)>0):
		toWrite.append("\n--" + x+ '\n')
		for y in range(4):
			toWrite.append('\n'+numberLine + ": ")
			numberLine =  str(int(numberLine)+1).zfill(3)
			if(y%4==3):
				toWrite.append(decod[:8])
			if(y%4==2):
				toWrite.append(decod[8:16])
			if(y%4==1):
				toWrite.append(decod[16:24])
			if(y%4==0):
				toWrite.append(decod[24:32])	
			toWrite.append(';')
		toWrite.append("\n")


for z in range(64):
	if(z>=count):
		n=31
		for y in range(32):
			if(y%8==0):
				toWrite.append('\n'+numberLine + ": ")
				numberLine =  str(int(numberLine)+1).zfill(3)
			toWrite.append('0')
			if(y%8==7):
				toWrite.append(';')
			n=n-1
	toWrite.append('\n')

toWrite.append('END;')

arq2.writelines(toWrite)		
arq.close()
arq2.close()

