.section .data

	car:
		.long 0									# variabile car di tipo .long

.section .text

	.global read_number
	.type read_number, @function

	read_number:								### LEGGO IL COMANDO ###
		pushl %eax								# memorizzo %eax in cima allo stack
		xorl %ebx, %ebx						# azzero registro %ebx

	start:
		pushl %ebx								# memorizzo %ebx in cima allo stack

		movl $3, %eax							# blocco di lettura
		movl $0, %ebx
		leal car, %ecx							# carico in %ecx indirizzo di car in cui verrà memorizzato il carattere letto
		mov $1, %edx							# lunghezza di 1 carattere
		int $0x80								# chiamata di sistema: leggo 1 carattere

		cmp $10, car							# controllo se è stato letto il carattere '\n'
		je end									# in caso positivo salto all'etichetta end
		subl $48, car
		popl %ebx								# ripristino %ebx
		addl car, %ebx							# sommo il valore di car al registro %ebx
		jmp start								# salto all'etichetta start

	end:
		popl %ebx								# ripristino registro %ebx
		popl %eax								# ripristino registro %eax
		ret										# esco dalla funzione
		
