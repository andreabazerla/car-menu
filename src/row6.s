.section .data

	str:											# stringa da stampare
		.ascii "Check olio"	
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global row6	
	.type row6, @function
	
	row6:											### SESTA RIGA ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo sesta riga
		movl $6, %eax							# 6 in %eax: siamo nella sesta riga
		ret										# esco dalla funzione
		
