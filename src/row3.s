.section .data

	str:											# stringa da stampare
		.ascii "Ora: 15:32"	
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global row3
	.type row3, @function
	
	row3:											### TERZA RIGA ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo terza riga
		movl $3, %eax							# 3 in %eax: siamo nella terza riga
		ret										# esco dalla funzione
