	.file	"integral.c"
	.intel_syntax noprefix
	.text
	.globl	integral
	.type	integral, @function
integral:
	push	rbp				# Добавляем rbp на стек
	mov	rbp, rsp			# rbp := rsp
	movsd	QWORD PTR -24[rbp], xmm0	# rbp[-24] := a
	movsd	QWORD PTR -32[rbp], xmm1	# rbp[-32] := b
	movsd	QWORD PTR -40[rbp], xmm2	# rbp[-40] := start
	movsd	QWORD PTR -48[rbp], xmm3	# rbp[-48] := finish
	pxor	xmm0, xmm0			# xmm0 := 0
	movsd	QWORD PTR -8[rbp], xmm0	# res(rbp[-8]) := 0
	movsd	xmm0, QWORD PTR -40[rbp]	# xmm0 := start
	movsd	QWORD PTR -16[rbp], xmm0	# i(rbp[-16]) := start
	jmp	.L2				# Переодим в L2
.L3:
	movsd	xmm0, QWORD PTR -32[rbp]	# xmm0 := b
	mulsd	xmm0, QWORD PTR -16[rbp]	#  /
	mulsd	xmm0, QWORD PTR -16[rbp]	# | xmm0 := xmm0 * i * i * i * i
	mulsd	xmm0, QWORD PTR -16[rbp]	# |
	mulsd	xmm0, QWORD PTR -16[rbp]	#  \
	movapd	xmm1, xmm0			# xmm1 := xmm0
	addsd	xmm1, QWORD PTR -24[rbp]	# xmm1 := xmm1 + a
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 := 0.0001
	mulsd	xmm0, xmm1			# xmm0 := xmm0 * xmm1
	movsd	xmm1, QWORD PTR -8[rbp]	# xmm1 := res
	addsd	xmm0, xmm1			# xmm0 := xmm0 + xmm1
	movsd	QWORD PTR -8[rbp], xmm0	# res := xmm0
	movsd	xmm1, QWORD PTR -16[rbp]	# xmm1 := i
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 := 0.0001
	addsd	xmm0, xmm1			# xmm0 := xmm0 + xmm1
	movsd	QWORD PTR -16[rbp], xmm0	# i := xmm0
.L2:
	movsd	xmm0, QWORD PTR -48[rbp]	# xmm0 := finish
	comisd	xmm0, QWORD PTR -16[rbp]	# Сраваниваем i с finish
	jnb	.L3				# Если i <= finish, то переходим в L3
	movsd	xmm0, QWORD PTR -16[rbp]	# xmm0 := i
	comisd	xmm0, QWORD PTR -48[rbp]	# Сравниваем  i с finish
	jbe	.L4				# Если i <= finish, то переходим в L4
	movsd	xmm0, QWORD PTR -32[rbp]	# xmm0 := b
	mulsd	xmm0, QWORD PTR -48[rbp]	#  /
	mulsd	xmm0, QWORD PTR -48[rbp]	# | xmm0 := xmm0 * i * i * i * i
	mulsd	xmm0, QWORD PTR -48[rbp]	# |
	mulsd	xmm0, QWORD PTR -48[rbp]	#  \
	movapd	xmm1, xmm0			# xmm1 := xmm0
	addsd	xmm1, QWORD PTR -24[rbp]	# xmm1 := xmm1 + a
	movsd	xmm0, QWORD PTR -16[rbp]	# xmm0 := finish
	movapd	xmm2, xmm0			# xmm2 := xmm0
	subsd	xmm2, QWORD PTR -48[rbp]	# xmm2 := xmm2 - i
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 := 0.0001
	subsd	xmm0, xmm2			# xmm0 := xmm0 - xmm2
	mulsd	xmm0, xmm1			# xmm0 := xmm0 * xmm1
	movsd	xmm1, QWORD PTR -8[rbp]	# xmm1 := res
	addsd	xmm0, xmm1			# xmm0 := xmm0 + xmm1
	movsd	QWORD PTR -8[rbp], xmm0	# res := xmm0
.L4:
	movsd	xmm0, QWORD PTR -8[rbp]	# xmm0 := res
	pop	rbp				# Удаляем rbp
	ret					# Выходим из функции
	.size	integral, .-integral
	.section	.rodata
	.align 8
.LC1:
	.long	3944497965
	.long	1058682594
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
