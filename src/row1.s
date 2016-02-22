.section .data

	str:											# stringa da stampare in modalità USER
		.ascii "Setting automobile:"
	str_len:										# lunghezza della stringa
		.long . - str

	sup:											# stringa da stmpare in modalità SUPERVISOR
		.ascii "Setting automobile (supervisor)"
	sup_len:										# lunghezza della stringa
		.long . - sup


.section .text

	.global row1
	.type row1, @function

	row1:											### PRIMA RIGA ###
		cmp $1, %ecx							# se %ecx è uguale a 1
		je supervisor							# salto all'etichetta supervisor

	user:											### MODALITA' USER ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo prima riga per modalità USER
		jmp end									# salto all'etichetta end

	supervisor:									### MODALITA' SUPERVISOR ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal sup, %ecx
		movl sup_len, %edx
		int $0x80								# stampo prima riga per modalità SUPERVISOR

	end:
		movl $1, %eax							# 1 in %eax: siamo nella prima riga
		ret										# esco dalla funzione
		
