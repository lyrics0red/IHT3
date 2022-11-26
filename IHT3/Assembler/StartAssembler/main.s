	.file	"main.c"
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
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$3, -84(%rbp)
	jne	.L2
	movq	-96(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-96(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-48(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	testq	%rax, %rax
	jne	.L5
	jmp	.L8
.L2:
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L6
.L8:
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L6
.L5:
	movq	-48(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	leaq	.LC3(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -24(%rbp)
	leaq	-56(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	leaq	-72(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdi, %r9
	movq	%rsi, %r8
	leaq	.LC4(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	movsd	-56(%rbp), %xmm2
	movsd	-64(%rbp), %xmm1
	movsd	-72(%rbp), %xmm0
	movq	-80(%rbp), %rax
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	integral@PLT
	movq	%xmm0, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %xmm0
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L6:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
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
