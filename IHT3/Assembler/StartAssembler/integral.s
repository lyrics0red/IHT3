	.file	"integral.c"
	.text
	.globl	integral
	.type	integral, @function
integral:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movsd	%xmm0, -24(%rbp)
	movsd	%xmm1, -32(%rbp)
	movsd	%xmm2, -40(%rbp)
	movsd	%xmm3, -48(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	movsd	-40(%rbp), %xmm0
	movsd	%xmm0, -8(%rbp)
	jmp	.L2
.L3:
	movsd	-32(%rbp), %xmm0
	mulsd	-8(%rbp), %xmm0
	mulsd	-8(%rbp), %xmm0
	mulsd	-8(%rbp), %xmm0
	mulsd	-8(%rbp), %xmm0
	movapd	%xmm0, %xmm1
	addsd	-24(%rbp), %xmm1
	movsd	.LC1(%rip), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	movsd	-8(%rbp), %xmm1
	movsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
.L2:
	movsd	-48(%rbp), %xmm0
	comisd	-8(%rbp), %xmm0
	jnb	.L3
	movsd	-8(%rbp), %xmm0
	comisd	-48(%rbp), %xmm0
	jbe	.L4
	movsd	-32(%rbp), %xmm0
	mulsd	-48(%rbp), %xmm0
	mulsd	-48(%rbp), %xmm0
	mulsd	-48(%rbp), %xmm0
	mulsd	-48(%rbp), %xmm0
	movapd	%xmm0, %xmm1
	addsd	-24(%rbp), %xmm1
	movsd	-8(%rbp), %xmm0
	movapd	%xmm0, %xmm2
	subsd	-48(%rbp), %xmm2
	movsd	.LC1(%rip), %xmm0
	subsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L4:
	movsd	-16(%rbp), %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
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
