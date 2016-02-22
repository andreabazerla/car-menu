.section .data

	str:											# stringa da stampare
		.ascii "Blocco porte automatico: "
	str_len:										# lunghezza della stringa
		.long . - str

	tab_str:										# stringa da stampare (TAB)
		.ascii "\tBlocco porte automatico: "
	tab_str_len:								# lunghezza della stringa (TAB)
		.long . - tab_str

	on:											# stringa stato ON
		.ascii "ON"
	on_len:										# lunghezza della stringa
		.long . - on

	off:											# stringa stato OFF
		.ascii "OFF"
	off_len:										# lunghezza della stringa
		.long . - off

.section .text

	.global row4
	.type row4, @function

	row4:
		pushl %ebx								# salvo %ebx in cima allo stack: contiene lo stato ON/OFF (1/0)
		cmp $1, %ecx							# confronto %ecx con 1
		je si_tab								# se %ecx = 1 salto all'etichetta si_tab
		jmp no_tab								# altrimenti salto all'etichetta no_tab

	si_tab:										### SOTTOMENU' BLOCCO PORTE AUTOMATICO (SUPERVISOR) ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal tab_str, %ecx
		movl tab_str_len, %edx
		int $0x80								# stampo la stringa tab_str ovvero il sottomenù
		jmp print_state						# salto all'etichetta print_state

	no_tab:										### BLOCCO PORTE AUTOMATICO (USER) ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								# stampo la stringa str

	print_state:								### STAMPA DELLO STATO BLOCCO PORTE AUTOMATICO (SUPERVISOR) ###
		popl %ebx								# estraggo dallo stack %ebx
		cmp $1, %ebx							# confronto %ebx con 1
		je print_on								# se %ebx = 1 salto all'etichetta print_on

	print_off:									### OFF ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal off, %ecx
		movl off_len, %edx
		int $0x80								# stampo OFF
		jmp end									# salto all'etichetta end

	print_on:									### ON ###
		movl $4, %eax							# blocco di stampa
		movl $1, %ebx
		leal on, %ecx
		movl on_len, %edx
		int $0x80								# stampo ON

	end:
		movl $4, %eax							# 4 in %eax: siamo nella quarta riga
		ret										# esco dalla funzione
		
