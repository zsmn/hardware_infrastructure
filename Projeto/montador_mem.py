arq = open('dados.txt', 'r')
arq2 = open('dados.mif', 'w')

group = arq.read()
arrayInst = group.split("\n")

get_bin = lambda x, n: format(x, 'b').zfill(n)

toWrite = []
toWrite.append('WIDTH = 8;\nDEPTH = 512;\n\nADDRESS_RADIX = DEC;\nDATA_RADIX = BIN;\n\nCONTENT\n\nBEGIN\n')

numberLine = '0'.zfill(3)
decod = ''

count = 0

for z in range(64):
	count =0;
	for x in arrayInst:
		if(len(x)>0):
			inst = x.split(" ")
			decod = get_bin(int(inst[1]),64)

			#print decod
			
			if(int(inst[0])==z):
				toWrite.append("\n--" + x+ '\n')
				for y in range(8):
					toWrite.append('\n'+numberLine + ": ")
					numberLine =  str(int(numberLine)+1).zfill(3)
					if(y%8==7):
						toWrite.append(decod[:8])
					if(y%8==6):
						toWrite.append(decod[8:16])
					if(y%8==5):
						toWrite.append(decod[16:24])
					if(y%8==4):
						toWrite.append(decod[24:32])
					if(y%8==3):
						toWrite.append(decod[32:40])
					if(y%8==2):
						toWrite.append(decod[40:48])
					if(y%8==1):
						toWrite.append(decod[48:56])
					if(y%8==0):
						toWrite.append(decod[56:64])					
					toWrite.append(';')
			toWrite.append("\n")


	if(count==0):
		n=63
		numberLine = str(z*8).zfill(3)
		for y in range(64):
			if(y%8==0):
				toWrite.append('\n'+numberLine + ": ")
				numberLine =  str(int(numberLine)+1).zfill(3)
			toWrite.append('0')
			n=n-1
			if(y%8==7):
				toWrite.append(';')
	toWrite.append('\n')


toWrite.append('END;')

arq2.writelines(toWrite)		
arq.close()
arq2.close()
