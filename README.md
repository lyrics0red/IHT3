# IHT3

## 1) Краснослободцев Кирилл Дмитриевич

## 2) БПИ218

## 3) 28 Вариант
Условие: Разработать программу численного интегрирования функции y = a + b ∗ x^4 (задаётся действительными числами а,b) в определённом диапазоне целых (задаётся так же) методом прямоугольниковьс избытком (точность вычислений = 0.0001).

## 4) Тесты
Текстовыые файлы с тестами расположены в папке <b>IHT3/IHT3/Tests</b>. В папке In расположены файлы с тестовыми входными данными. В папке Out расположены файлы, которые соответствуют корректным выходным данным (<b>in1.txt</b> -> <b>out1.txt</b>; <b>in2.txt</b> -> <b>out2.txt</b>; <b>in3.txt</b> -> <b>out3.txt</b>). 

## 5) Тестовые прогоны
<p>В папке <b>IHT3/IHT3/Tests/Results</b> расположены результаты тестовых прогонов исполняемых файлов, полученных компиляцией C файлов (<b>fromC.exe</b>) и компиляцией отредактированных файлов ассемблера (<b>afterRefactorFromAssem.exe</b>).</p>
<p>Соответствие тестов:</p>
<p><b>fromC.exe</b>: <b>in1.txt</b> -> <b>FromC/res1.txt</b>; <b>in2.txt</b> -> <b>FromC/res2.txt</b>; <b>in3.txt</b> -> <b>FromC/res3.txt</b></p>
<p><b>afterRefactorFromAssem.exe</b>: <b>in1.txt</b> -> <b>FromAssem/res1.txt</b>; <b>in2.txt</b> -> <b>FromAssem/res2.txt</b>; <b>in3.txt</b> -> <b>FromAssem/res3.txt</b></p>
<p>Демонстрация запуска исполняемых файлов на разных входных данных и их соответствие нужному результату могут быть найдены в папке <b>IHT3/IHT3/Screenshots</b>. <b>testC.jpg</b> демонстрирует тестовый прогон исполняемого файла, полученного компиляцией программы на C. <b>testAssem.jpg</b> демонстрирует тестовый прогон исполняемого файла, полученного компиляцией программы на отредактированном ассемблере.</p>

![image](https://user-images.githubusercontent.com/90769620/204155308-d168e632-bec1-48b9-99ec-d2945b4927af.png)
![image](https://user-images.githubusercontent.com/90769620/204155460-542f89cf-706b-482a-8147-9fb838bddd7d.png)

## 6) Исходные тексты программы на C
<p>В папке <b>IHT3/IHT3/C</b> расположены файлы программы на C: <b>main.c</b> и <b>modify.c</b></p>

<b>main.c</b>:

    #include <stdio.h>

    extern double integral(double a, double b, double start, double finish);

    int main(int argc, char** argv) {
	  FILE* input;
	  FILE* output;
	  char* instr;
	  char* outstr;

	  if (argc == 3) {
		  instr = argv[1];
		  outstr = argv[2];
	  } else {
		  printf("Incorect number of parameters.");
		  return 1;
	  }

	  if (fopen(instr, "r") == NULL) {
		  printf("Incorrect name of input file.");
		  return 1;
	  }

	  input = fopen(instr, "r");
	  output = fopen(outstr, "w");

	  double a, b, start, finish;
	  fscanf(input, "%lf%lf%lf%lf", &a, &b, &start, &finish);
	
	  double res = integral(a, b, start, finish);
	  fprintf(output, "%lf", res);

	  fclose(input);
	  fclose(output);	
    }
    
<b>integral.c</b>:

    double integral(double a, double b, double start, double finish) {
	    double res = 0, i;
	    for (i = start; i <= finish; i += 0.0001) {
		    res += (a + b * i * i * i * i) * 0.0001;
	    }
	    if (i > finish) {
		    res += (a + b * finish * finish * finish * finish) * (0.0001 - (i - finish));
	    }
	    return res;
    }

## 7) Тексты программы на языке ассемблера, расширенные комментариями
<p>В папке <b>IHT3/IHT3/Assembler</b> расположены файлы программы на языке ассемблера. В папке <b>BeforeRefactor</b> лежат файлы ассемблера до рефакторинга программы за счет оптимизации регистров процессора. В папке <b>AfterRefactor</b> лежат файлы ассемблера после рефакторинга программы за счет оптимизации регистров процессора. Комментарии прописаны только для окончательных файлов ассемблера, то есть лежащих в папке <b>AfterRefactor</b>.</p>

<b>main.s</b>:

    # r12d := rbp[-84]
	  .intel_syntax noprefix
	  .text
	  .section	.rodata
	  .align 8
	
    .LC0:
	    .string	"Incorect number of parameters."  # Строка "Incorect number of parameters."
	
    .LC1:
	    .string	"r" # Строка "r"
	
    .LC2:
	    .string	"Incorrect name of input file." # "Incorrect name of input file."
	
    .LC3:
	    .string	"w" # Строка "w"
	
    .LC4:
	    .string	"%lf%lf%lf%lf" # Строка "%lf%lf%lf%lf"
	
    .LC5:
	    .string	"%lf" # Строка "%lf"
	
	  .text # Секция с кодом
	  .globl	main # Функция main
	
    main:
	    push	rbp						# Добавляем rbp на стек
	    mov	rbp, rsp					# rbp := rsp
	    sub	rsp, 96					# Выделение памяти на стеке
	    mov	r12d, edi					# r12d := argc
	    mov	QWORD PTR -96[rbp], rsi			# rbp[-96] := argv
	    cmp	r12d, 3					# Сравниваем argc с 3
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
	    call	integral@PLT			# integral(a, b, start, finish)		
	    movq	rax, xmm0         # rax := xmm0 (res)
	    mov	QWORD PTR -40[rbp], rax # rbp[-40] := rax
	    mov	rdx, QWORD PTR -40[rbp] # rdx := res
	    mov	rdi, QWORD PTR -32[rbp] # rdi := output - 1-й аргумент
	    movq	xmm0, rdx # xmm0 := rdx - 3-й аргумент
	    lea	rsi, .LC5[rip] # rsi := &(строка "%lf") - 2-й аргумент
	    mov	eax, 1 # eax := 1
	    call	fprintf@PLT # fprintf(output, "%lf", res);
	    mov	rdi, QWORD PTR -24[rbp] # rdi := input - 1-й аргумент
	    call	fclose@PLT  # fclose(input);
	    mov	rdi, QWORD PTR -32[rbp] # rdi := output - 1-й аргумент
	    call	fclose@PLT # fclose(output)
	    mov	eax, 0 # eax := 0
 	
    .L6:
	    leave # / Выходим из функции
	    ret # \
			
<b>integral.s</b>:

      .intel_syntax noprefix
	  .text
	  .globl	integral
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
	    mulsd	xmm0, QWORD PTR -48[rbp]	# | xmm0 := xmm0 * finish * finish * finish * finish
	    mulsd	xmm0, QWORD PTR -48[rbp]	# |
	    mulsd	xmm0, QWORD PTR -48[rbp]	#  \
	    movapd	xmm1, xmm0			# xmm1 := xmm0
	    addsd	xmm1, QWORD PTR -24[rbp]	# xmm1 := xmm1 + a
	    movsd	xmm0, QWORD PTR -16[rbp]	# xmm0 := finish
	    movapd	xmm2, xmm0			# xmm2 := xmm0
	    subsd	xmm2, QWORD PTR -48[rbp]	# xmm2 := xmm2 - finish
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

## 8) Тексты программы на языке ассемблера
<b>main.s</b>:

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
    
<b>integral.s</b>:

	    .file	"integral.c"
	    .text
	    .globl	integral
	    .type	integral, @function
    integral:
    .LFB0:
	    .cfi_startproc
	    endbr64
	    pushq	%rbp
	    .c fi_def_cfa_offset 16
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
    
## 9) Дополнительная информация
Для получения ассемблерного кода, была применена следующая команда в терминале
<p>gcc -masm=intel \ 
  <p>-fno-asynchronous-unwind-tables \</p>
  <p>-fno-jump-tables \ </p>
  <p>-fno-stack-protector \ </p>
  <p>-fno-exceptions \ </p>
  <p>./main.c ./modify.c \ </p>
  <p>-S </p>
<p>Полученный ассеблер был вручную избавлен от лишних макросов.</p>
После этого были проведены оптимизации кода на языке ассемблера: из кода modify.s были убраны команды nop, несколько строк типа <p>mov rax, QWORD PTR ...[rbp]</p> <p>mov rdi, rax</p> были заменены на mov rdi, QWORD PTR ...[rbp]
<p>В программе используются локальные переменные, функции с передачей данных через параметры</p>
<p>Был проведен рефакторинг кода на ассемблере за счет оптимизации регистров процессора: -84[rbp] заменен на r12d</p>
<p>В связи с этим удалось достичь уменьшения размеров исполняемых файлов (размеры файлов указаны в файлах <b>IHT3/IHT3/Screenshots/sizeAfterRefact</b> и <b>IHT3/IHT3/Screenshots/sizeBeforeRefact</b>)</p>

![image](https://user-images.githubusercontent.com/90769620/204154986-832ed52f-d334-4a17-9b45-9b4090cf6206.png)
![image](https://user-images.githubusercontent.com/90769620/204154998-8c1c0151-0620-4637-a2da-5663da085707.png)

<p>Программа реализована в виде двух единиц компиляции.</p>
<p>Используются файлы для ввода данных и вывода результатов. Названия файлов подаются, как параметры командной строки.</p>
<p>Совершена компиляция программы на C и на ассемблере. Запуская исполняемые файлы на тестовых входных данных (расположенных в текстовых файлах) были получены одинаковые корректные результаты. (пункт 5 настоящего отчета).</p>
<p>В коде ассемблера в папке <b>IHT3/IHT3/Assembler/AfterRefactor</b> присутствуют коментарии о локальных переменных, передаче параметров в функции, использовании результатов функций, оптимизации за счет регистров процессора.</p>
