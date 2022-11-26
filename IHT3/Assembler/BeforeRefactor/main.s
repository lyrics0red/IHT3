	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
	
.LC0:
	.string	"Incorect number of parameters."
	
.LC1:
	.string	"r"
	
.LC2:
	.string	"Incorrect name of input file."
	
.LC3:
	.string	"w"
	
.LC4:
	.string	"%lf%lf%lf%lf"
	
.LC5:
	.string	"%lf"
	
	.text
	.globl	main
	
main:
	push	rbp						# Добавляем rbp на стек
	mov	rbp, rsp					# rbp := rsp
	sub	rsp, 96					# Выделение памяти на стеке
	mov	DWORD PTR -84[rbp], edi			# rbp[-84] := argc
	mov	QWORD PTR -96[rbp], rsi			# rbp[-96] := argv
	cmp	DWORD PTR -84[rbp], 3				# Сравниваем argc с 3
	jne	.L2						# Если argc != 3, то переходим в L2
	mov	rax, QWORD PTR -96[rbp]			# rax := argv
	mov	rax, QWORD PTR 8[rax]				# rax := argv[1]
	mov	QWORD PTR -8[rbp], rax				# instr := argv[1]
	mov	rax, QWORD PTR -96[rbp]			# rax := argv
	mov	rax, QWORD PTR 16[rax]				# rax := argv[2]
	mov	QWORD PTR -16[rbp], rax			# outstr := argv[2]
	mov	rdi, QWORD PTR -8[rbp]				# rdi := instr - 1-й аргумент
	lea	rsi, .LC1[rip]					# rsi = &(строка "r") - 2-й аргумент
	call	fopen@PLT					# fopen(instr, "r");
	test	rax, rax					# Проверка fopen(instr, "r") != null
	jne	.L5						# Если fopen(instr, "r") != null, то переходим в L5
	jmp	.L7						# Переходим в L7
	
.L2:
	lea	rdi, .LC0[rip]					# rdi := &(строка - "Incorect number of parameters.") - 1-й аргумент
	call	printf@PLT					# printf("Incorect number of parameters.");
	mov	eax, 1						# eax := 1
	jmp	.L6						# Переходим в L6

.L7:
	lea	rdi, .LC2[rip]					# rdi := &(строка - "Incorrect name of input file.") - 1-й аргумент
	call	printf@PLT					# printf("Incorrect name of input file.");
	mov	eax, 1						# eax := 1
	jmp	.L6						# Переходим в L6
	
.L5:
	mov	rdi, QWORD PTR -8[rbp]				# rdi := instr - 1-й аргумент
	lea	rsi, .LC1[rip]					# rsi := &(строка - "r" )- 2-й аргумент
	call	fopen@PLT					# fopen(instr, "r");
	mov	QWORD PTR -24[rbp], rax			# input = fopen(instr, "r");
	mov	rdi, QWORD PTR -16[rbp]			# rdi := outstr - 1-й аргумент	
	lea	rsi, .LC3[rip]					# rsi := &(строка - "w") - 2-й аргумент
	call	fopen@PLT					# fopen(outstr, "w");
	mov	QWORD PTR -32[rbp], rax			# output = fopen(outstr, "w");
	lea	r9, -72[rbp]					# r9 := &a (rbp[-72] = finish) - 6-й аргумент
	lea	r8, -64[rbp]					# r8 := &b (rbp[-64] = start) - 5-й аргумент
	lea	rcx, -56[rbp]					# rcx := &start (rbp[-56] = b) - 4-й аргумент
	lea	rdx, -48[rbp]					# rdx := &finish (rbp[-48] = a) - 3-й аргумент
	mov	rdi, QWORD PTR -24[rbp]			# rdi := input - 1-й аргумент
	lea	rsi, .LC4[rip]					# rsi := &(строчка "r") - 2-й аргумент
	mov	eax, 0						# eax := 0
	call	__isoc99_fscanf@PLT				# fscanf(input, "r", a, b, start, finish);
	movsd	xmm2, QWORD PTR -72[rbp]			# xmm2 := finish
	movsd	xmm1, QWORD PTR -64[rbp]			# xmm1 := start
	movsd	xmm0, QWORD PTR -56[rbp]			# xmm0 := b
	mov	rax, QWORD PTR -48[rbp]			# rax := a
	movapd	xmm3, xmm2					# xmm3 := finish - 4-й аргумент
	movapd	xmm2, xmm1					# xmm2 := start - 3-й аргумент
	movapd	xmm1, xmm0					# xmm1 := b - 2-й аргумент
	movq	xmm0, rax					# xmm0 := a - 1-й аргумент
	call	integral@PLT					
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
	
.L6:
	leave
	ret
