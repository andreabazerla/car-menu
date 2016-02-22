.section .data

	str:											# stringa da stampare
		.ascii "Data: 15/06/2014"
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global row2
	.type row2, @function

	row2:											### SECONDA RIGA ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo seconda riga
		movl $2, %eax							# 2 in %eax: siamo nella seconda riga
		ret										# esco dalla funzione
