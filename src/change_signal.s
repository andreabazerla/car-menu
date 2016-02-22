.section .data

	str:											# variabile stringa per stampare il numero di lampeggi
		.ascii "\tNumero lampeggi: "
	str_len:
		.long . - str
	flash:										# variabile numero lampeggi frecce direzionali
		.long 0

.section .text

	.global change_signal
	.type change_signal, @function

	change_signal:								### CAMBIO NUMERO LAMPEGGI FRECCE DIREZIONALI ###
		movl %ebx, flash						# sposto il parametro ricevuto nella variabile flash

		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# chiamata di sistema: stampo la stringa str

		movl flash, %eax						# sposto il contenuto della variabile flash nel registro %eax
		call itoa								# chiamo la funzione ITOA per la conversione da numero a stringa

		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# chiamata di sistema: stampo la stringa str

		call read_number						# chiamo la funzione read_number

		cmp $2, %ebx							# se viene inserito un numero minore di 2
		jl min									# salto all'etichetta min

		cmp $5, %ebx							# se viene inserito un numero maggiore di 5
		jg max									# salto all'etichetta max

		jmp end									# salto all'etichetta end

	min:											### NUMERO LAMPEGGI MINIMO ###
		movl $2, %ebx							# in %ebx inserisco 2
		jmp end									# salto all'etichetta end

	max:											### NUMERO LAMPEGGI MASSIMO ###
		movl $5, %ebx							# in %ebx inserisco 5

	end:
		ret										# esco dalla funzione

