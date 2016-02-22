.section .data

	str:											# stringa da stampare
		.ascii "Frecce direzione"
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global row7
	.type row7, @function

	row7:											### SETTIMA RIGA ### (SUPERVISOR)
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo settima riga
		movl $7, %eax							# 7 in %eax: siamo nella settima riga
		ret										# esco dalla funzione
