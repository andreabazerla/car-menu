.section .data

	str:											# stringa da stampare
		.ascii "Reset pressione gomme"
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global row8
	.type row8, @function

	row8:											### OTTAVA RIGA ### (SUPERVISOR)
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo ottava riga
		movl $8, %eax							# 8 in %eax: siamo nella ottava riga
		ret										# esco dalla funzione
