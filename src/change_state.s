.section .data

	row:											# variabile dove salvare il numero della riga corrente del menù
		.long 0
	state:										# variabile dove salvare lo stato corente (ON/OFF = 1/0)
		.long 0

.section .text

	.global change_state
	.type change_state, @function

	change_state:								### FUNZIONE CAMBIO STATO ###
		movl %eax, row							# (RIGA) memorizzo nella variabile row il contenuto del registro %eax
		movl %ebx, state						# (STATO) memorizzo nella variabile state il contenuto del registro %ebx

	start:
		cmp $4, row								# confronto 4 con $row (sono nella riga?)
		je fourth_row							# se risulta positivo salto all'etichetta fourth_row
		jmp fifth_row							# altrimenti salto all'etichetta fifth_row

	fourth_row:									### QUARTA RIGA ###
		movl state, %ebx						# carico in %ebx la variabile state
		movl $1, %ecx							# carico in %ecx 1
		call row4								# chiamo la funzione row4
		jmp command								# salto all'etichetta command

	fifth_row:									### QUINTA RIGA ###
		movl state, %ebx						# carico in %ebx la variabile state
		movl $1, %ecx							# carico in %ecx 1
		call row5								# chiamo la funzione row5
		jmp command								# salto all'etichetta command

	command:										### COMANDO ###
		call read_command						# chiamo la funzione read_command per leggere il comando inserito dall'utente
		cmp $183, %ebx							### FRECCIA SU ###
		je change								
		cmp $184, %ebx							### FRECCIA GIU' ###
		je change
		cmp $0, %ebx							### INVIO ###
		je end
		jmp start

	change:
		cmp $1, state							# confronto 1 con la variabile state per vedere se lo stato è ON
		je turn_off								# se risulta positivo lo porto ad OFF saltando all'etichetta turn_off

	turn_on:										### OFF -> ON ###
		movl $1, state							# memorizzo 1 nella variabile state per accendere lo stato
		jmp start								# salto all'etichetta start per ristampare con lo stato aggiornato

	turn_off:									### ON -> OFF ###
		movl $0, state							# memorizzo 0 nella variabile state per spegnere lo stato
		jmp start								# salto all'etichetta start per ristampare con lo stato aggiornato

	end:											### TERMINE DELLA FUNZIONE ###
		movl state, %ebx						# carico la variabile state in %ebx
		ret										# esco dalla funzione

