.section .data
													### MESSAGGI DI ERRORE ###
	error_1:										# stringa di errore 1
		.ascii "Errore 1: troppi parametri. Riprovare\n"
	error_1_len:
		.long . - error_1

	error_2:										# stringa di errore 2
		.ascii "Errore 2: codice errato. Riprovare\n"
	error_2_len:
		.long . - error_2

.section .text

	.global _start
	_start:

		popl %eax								# estraggo dallo stack il numero di parametri
		cmp $2, %eax							# confronto se %eax è uguale o no a 2
		je get_parameter						# se uguale a 2, salto all'etichetta get_parameter
		jg print_error_1						# se invece maggiore di 2, salto all'etichetta print_error_1

													### MODALITA' USER ###
		movl $1, %eax							# 1 in %eax: prima riga del relativo menù
		movl $0, %ebx							# 0 in %ebx: modalità di accesso USER

		call menu								# chiamo funzione menu
		jmp end									# salto all'etichetta end

	get_parameter:								### LETTURA DEI PARAMETRI ###
		pop %eax									# estraggo il nome dell'eseguibile dallo stack
		pop %eax									# estraggo il primo parametro

		call atoi								# chiamo funzione atoi: salvo in %eax il numero inserito

		cmp $2244, %eax						# lo confronto con il codice 2244
		je supervisor_modality				# se uguale, accedo in modalità supervisor
		jne print_error_2						# altrimenti stampo errore 2: codice errato!


	supervisor_modality:						### MODALITA' SUPERVISOR ###
		movl $1, %eax							# 1 in %eax: prima riga del relativo menù
		movl $1, %ebx							# 1 in %ebx: modalità di accesso SUPERVISOR

		call menu								# chiamo funzione menu
		jmp end									# salto all'etichetta end

	print_error_2:								### ERRORE 2 ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal error_2, %ecx
		movl error_2_len, %edx
		int $0x80								# stampo errore 2
		jmp end									# salto all'etichetta end

	print_error_1:								### ERRORE 1 ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal error_1, %ecx
		movl error_1_len, %edx
		int $0x80								# stampo errore 1
		jmp end									# salto all'etichetta end

	end:											### TERMINE DEL PROGRAMMA ###
		movl $1, %eax
		movl $0, %ebx
		int $0x80

