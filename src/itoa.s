.section .data
car:
	.byte 0

.section .text

.global itoa

.type itoa, @function

itoa:
	movl $0, %ecx
continua_a_dividere:

	cmp $10, %eax
	jge dividi
	pushl %eax
	incl %ecx
	movl %ecx, %ebx
	jmp stampa

dividi:
	movl $0, %edx
	movl $10, %ebx
	divl %ebx
	pushl %edx
	incl %ecx
	jmp continua_a_dividere

stampa:
	cmp $0, %ebx
	je fine_itoa
	popl %eax
	movb %al, car
	addb $48, car
	decl %ebx
	pushl %ebx
	movl $4, %eax
	movl $1, %ebx
	leal car, %ecx
	movl $1, %edx
	int $0x80
	popl %ebx
	jmp stampa

fine_itoa:
	movb $10, car
	movl $4, %eax
	movl $1, %ebx
	leal car, %ecx
	movl $1, %edx
	int $0x80
	ret


