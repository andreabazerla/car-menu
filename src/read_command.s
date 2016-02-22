.section .data

	car:											# variabile car di tipo .long
		.long 0

.section .text

	.global read_command
	.type read_command, @function

	read_command:								### LEGGO IL COMANDO ###
		pushl %eax								# memorizzo %eax in cima allo stack
		xorl %ebx, %ebx						# azzero %ebx

	start:
		pushl %ebx								# memorizzo sullo stack %eax
		
		movl $3, %eax							# blocco di lettura
		movl $0, %ebx
		leal car, %ecx							# carico in %ecx indirizzo di car in cui verrà memorizzato il carattere letto
		mov $1, %edx							# lunghezza di 1 carattere
		int $0x80								# chiamata di sistema: leggo 1 carattere

		cmp $10, car							# controllo se è stato letto il carattere '\n'
		je end									# in caso positivo salto all'etichetta end

		popl %ebx								# ???
		addl car, %ebx							# ???
		jmp start								# ???

	end:
		popl %ebx								# ripristino registro %ebx
		popl %eax								# ripristino registro %eax
		ret										# esco dalla funzione
		
