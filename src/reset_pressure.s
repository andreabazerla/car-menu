.section .data

	str:											# stringa da stampare
		.ascii "\tPressione gomme resettata\n"
	str_len:										# lunghezza della stringa
		.long . - str

.section .text

	.global reset_pressure
	.type reset_pressure, @function

	reset_pressure:							### RESET PRESSIONE GOMME ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo la stringa
		ret										# esco dalla funzione		
