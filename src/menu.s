.section .data

	modality:									# variabile dove salvare la modalità di accesso al menù
		.long 0

	row4_state:									# variabile dove salvare lo stato blocco porte automatico (ON/OFF = 1/0)
		.long 1

	row5_state:									# variabile dove salvare lo stato back-home (ON/OFF = 1/0)
		.long 1

	flash:										# variabile dove salvare il numero di lampeggi delle frecce direzionali
		.long 3

.section .text

	.global menu
	.type menu, @function

	menu:											### MODALITA' ###
		movl %ebx, modality					# salvo la modalità avviata di %ebx nella variabile modality

	next_row:									### PROSSIMA RIGA? ###
		cmp $1, %eax							# in base al valore in %eax salto all'etichetta per la stampa della rispettiva riga
		je first_row

		cmp $2, %eax
		je second_row

		cmp $3, %eax
		je third_row

		cmp $4, %eax
		je fourth_row

		cmp $5, %eax
		je fifth_row

		cmp $6, %eax
		je sixth_row

		cmp $7, %eax
		je seventh_row

		cmp $8, %eax
		je eighth_row

	first_row:									### PRIMA RIGA ###
		movl modality, %ecx					# carico in %ecx il valore della variabile modality
		call row1								# chiamo la funzione row1 per la stampa della prima riga
		jmp command								# salto all'etichetta command

	second_row:									### SECONDA RIGA ###
		call row2								# chiamo la funzione row2 per la stampa della seconda riga
		jmp command								# salto all'etichetta command

	third_row:									### TERZA RIGA ###
		call row3								# chiamo la funzione row3 per la stampa della terza riga
		jmp command								# salto all'etichetta command

	fourth_row:									### QUARTA RIGA ###
		movl row4_state, %ebx				# carico in %ebx lo stato del blocco porte automatico (row4)
		movl $0, %ecx							# carico 0 in %ecx per la stampa senza tab
		call row4								# chiamo la funzione row4 per la stampa della quarta riga
		jmp command								# salto all'etichetta command

	fifth_row:									### QUINTA RIGA ###
		movl row5_state, %ebx				# carico in %ebx lo stato del back-home (row5)
		movl $0, %ecx							# carico 0 in %ecx per la stampa senza tab
		call row5								# chiamo la funzione row5 per la stampa della quinta riga
		jmp command								# salto all'etichetta command

	sixth_row:								### SESTA RIGA ###
		call row6								# chiamo la funzione row6 per la stampa della sesta riga
		jmp command								# salto all'etichetta command

	seventh_row:								### SETTIMA RIGA ### (SUPERVISOR)
		call row7								# chiamo la funzione row7 per la stampa della settima riga
		jmp command								# salto all'etichetta command

	eighth_row:									### OTTAVA RIGA ### (SUPERVISOR)
		call row8								# chiamo la funzione row8 per la stampa della ottava riga
		jmp command								# salto all'etichetta command

	command:										
		call read_command						# chiamo la funzione command per leggere il comando inserito dall'utente

	count_next_row:							### CALCOLO RIGA SUCCESSIVA ###
		cmp $183, %ebx							# frecca SU (183)
		je previous								# salto all'etichetta previus per la stampa della riga precedente

		cmp $184, %ebx							# frecca GIU' (184)
		je following							# salto all'etichetta following per la stampa della riga successiva

		cmp $185, %ebx							# frecca DESTRA (185)
		je submenu								# salto all'etichetta submenu per entrare nel relativo sottomenù

		cmp $0, %ebx							# INVIO (0)
		je end									# salto all'etichetta end

		jmp reprint_row						# se non viene riconosciuto il comando inserito salto all'etichetta reprint_row per ristampare la riga

	previous:									### RIGA PRECEDENTE ###
		decl %eax								# decremento %eax: indice di riga
		cmp $0, %eax							# confronto %eax con 0 (prima riga del menù)
		je first_row							# salto all'etichetta first_row
		jmp next_row							# altrimenti salto all'etichetta next_row

	following:									### RIGA SUCCESSIVA ###
		incl %eax								# incremento %eax: indice di riga
		cmp $7, %eax							# confronto %eax con 7: settima riga del menù
		je check_modality						# se il confronto è positivo salto all'etichetta check_modality

		cmp $9, %eax							# confronto %eax con 9: nona riga del menù
		je first_row							# se il confronto è positivo salto all'etichetta first_row

		jmp next_row							# altrimenti salto all'etichetta next_row

	check_modality:							### CONTROLLO MODALITA' AVVIATA ###
		cmp $0, modality						# confronto modality con 0: modalità USER
		je first_row							# se sono in modalità USER dalla settima riga salto direttamente alla prima riga del menù
		jmp seventh_row						# altrimenti sono in modalità SUPERVISOR e salto all'etichetta seventh_row per 

	submenu:										### SOTTOMENU' ###
		cmp $4, %eax							# a seconda della riga in cui mi trovo
		je submenu_4							# salto al relativo sottomenù

		cmp $5, %eax
		je submenu_5

		cmp $7, %eax
		je submenu_7

		cmp $8, %eax
		je submenu_8

		jmp reprint_row						# salto all'etichetta reprint_row per ristampare la riga del menù in cui ero se non presenta sottomenù

	submenu_4:									### SOTTOMENU' BLOCCO PORTE AUTOMATICO ###
		movl row4_state, %ebx				# carico in %ebx lo stato del blocco porte automatico
		call change_state						# chiamo la funzione change_state
		movl %ebx, row4_state				# memorizzo lo stato contenuto in %ebx nella variabile row4_state
		jmp fourth_row							# salto all'etichetta fourth_row

	submenu_5:									### SOTTOMENU' BACK-HOME ###
		movl row5_state, %ebx				# carico in %ebx lo stato del back-home
		call change_state						# chiamo la funzione change_state
		movl %ebx, row5_state				# memorizzo lo stato contenuto in %ebx nella variabile row5_state
		jmp fifth_row							# salto all'etichetta fifth_row

	submenu_7:									### SOTTOMENU' FRECCE DIREZIONALI ###
		movl flash, %ebx						# carico in %ebx il numero dei lampeggi delle frecce direzionali
		call change_signal					# chiamo la funzione change_signal
		movl %ebx, flash						# memorizzo lo stato contenuto in %ebx nella variabile flash
		jmp seventh_row						# salto all'etichetta seventh_row

	submenu_8:									### SOTTOMENU' RESET PRESSIONE GOMME ###
		call reset_pressure					# chiamo la funzione reset_pressure
		jmp eighth_row							# salto all'etichetta eighth_row

	reprint_row:								### RISTAMPA RIGA CORRENTE ###
		jmp next_row							# salto all'etichetta next_row

	end:											### TERMINE DELLA FUNZIONE ###
		ret										# esco dalla funzione
		
