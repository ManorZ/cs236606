	.text
	.file	"driver.c"
	.globl	start_timer                     # -- Begin function start_timer
	.p2align	4, 0x90
	.type	start_timer,@function
start_timer:                            # 
.Lfunc_begin0:
	.file	1 "/home/u166450/practice8/compiler-optimization/vectorization/matvector/c/solutions/align" "driver.c"
	.loc	1 32 0                          # driver.c:32:0
	.cfi_startproc
# %bb.0:
	.loc	1 34 5 prologue_end             # driver.c:34:5
	movl	$tstart, %edi
	xorl	%esi, %esi
	jmp	gettimeofday                    # TAILCALL
.Ltmp0:
.Lfunc_end0:
	.size	start_timer, .Lfunc_end0-start_timer
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function stop_timer
.LCPI1_0:
	.quad	0x3eb0c6f7a0b5ed8d              #  9.9999999999999995E-7
	.text
	.globl	stop_timer
	.p2align	4, 0x90
	.type	stop_timer,@function
stop_timer:                             # 
.Lfunc_begin1:
	.loc	1 41 0                          # driver.c:41:0
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
.Ltmp1:
	.loc	1 43 5 prologue_end             # driver.c:43:5
	movl	$tstop, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	.loc	1 44 13                         # driver.c:44:13
	vcvtsi2sdq	tstop(%rip), %xmm0, %xmm0
	.loc	1 44 28 is_stmt 0               # driver.c:44:28
	vcvtsi2sdq	tstop+8(%rip), %xmm1, %xmm1
	.loc	1 45 13 is_stmt 1               # driver.c:45:13
	vcvtsi2sdq	tstart(%rip), %xmm2, %xmm2
	.loc	1 44 26                         # driver.c:44:26
	vsubsd	%xmm2, %xmm0, %xmm0
	.loc	1 45 29                         # driver.c:45:29
	vcvtsi2sdq	tstart+8(%rip), %xmm3, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmulsd	.LCPI1_0(%rip), %xmm1, %xmm1
	.loc	1 44 55                         # driver.c:44:55
	vaddsd	%xmm1, %xmm0, %xmm0
	.loc	1 44 5 is_stmt 0                # driver.c:44:5
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Ltmp2:
.Lfunc_end1:
	.size	stop_timer, .Lfunc_end1-stop_timer
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function init_matrix
.LCPI2_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI2_1:
	.quad	0x4024000000000000              #  10
	.text
	.globl	init_matrix
	.p2align	4, 0x90
	.type	init_matrix,@function
init_matrix:                            # 
.Lfunc_begin2:
	.loc	1 54 0 is_stmt 1                # driver.c:54:0
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$168, %rsp
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	.loc	1 57 19 prologue_end            # driver.c:57:19
	testl	%edi, %edi
	.loc	1 57 5 is_stmt 0                # driver.c:57:5
	jle	.LBB2_11
# %bb.1:
	movq	%rdx, %r12
	vmovapd	%xmm0, %xmm2
	movl	%esi, %r14d
	.loc	1 57 19                         # driver.c:57:19
	movl	%edi, %eax
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	movl	%esi, %r13d
	decq	%rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	.loc	1 57 5                          # driver.c:57:5
	movl	%r13d, %eax
	andl	$-4, %eax
	movq	%rax, (%rsp)                    # 8-byte Spill
	.loc	1 59 34                         # driver.c:59:34
	vmovddup	%xmm0, %xmm0                    # xmm0 = xmm0[0,0]
	vinsertf128	$1, %xmm0, %ymm0, %ymm0
	vmovupd	%ymm0, 128(%rsp)                # 32-byte Spill
	xorl	%r15d, %r15d
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	vmovupd	%xmm2, 16(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_10:                               #   in Loop: Header=BB2_2 Depth=1
	.loc	1 57 19                         # driver.c:57:19
	leaq	1(%r15), %rax
	.loc	1 57 5 is_stmt 0                # driver.c:57:5
	addq	$504, %r12                      # imm = 0x1F8
	.loc	1 57 19                         # driver.c:57:19
	cmpq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	%rax, %r15
	.loc	1 57 5                          # driver.c:57:5
	je	.LBB2_11
.LBB2_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_8 Depth 2
                                        #     Child Loop BB2_6 Depth 2
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	testl	%r14d, %r14d
	.loc	1 58 9 is_stmt 0                # driver.c:58:9
	jle	.LBB2_10
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	movq	(%rsp), %rbp                    # 8-byte Reload
	.loc	1 57 5 is_stmt 1                # driver.c:57:5
	testq	%rbp, %rbp
	.loc	1 58 9                          # driver.c:58:9
	je	.LBB2_4
# %bb.7:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%r14d, %ebx
	.loc	1 59 28                         # driver.c:59:28
	vmovd	%r15d, %xmm0
	vpshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	vmovdqu	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB2_8:                                #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovd	%r14d, %xmm0
	vpshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	vpor	.LCPI2_0(%rip), %xmm0, %xmm0
	vpmulld	64(%rsp), %xmm0, %xmm0          # 16-byte Folded Reload
	vcvtdq2pd	%xmm0, %ymm0
	.loc	1 59 34 is_stmt 0               # driver.c:59:34
	vaddpd	128(%rsp), %ymm0, %ymm0         # 32-byte Folded Reload
	vmovupd	%ymm0, 32(%rsp)                 # 32-byte Spill
	.loc	1 59 23                         # driver.c:59:23
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 112(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	32(%rsp), %ymm0                 # 32-byte Reload
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	32(%rsp), %ymm0                 # 32-byte Reload
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 32(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	32(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	.loc	1 59 21                         # driver.c:59:21
	vunpcklpd	80(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 16(%r12,%r14,8)
	vmovupd	96(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	112(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovupd	%xmm0, (%r12,%r14,8)
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	addq	$4, %r14
	cmpq	%rbp, %r14
	.loc	1 58 9 is_stmt 0                # driver.c:58:9
	jb	.LBB2_8
# %bb.9:                                #   in Loop: Header=BB2_2 Depth=1
	movq	%rbp, %rcx
	movq	%r13, %rax
	.loc	1 57 5 is_stmt 1                # driver.c:57:5
	cmpq	%r13, %rbp
	vmovupd	16(%rsp), %xmm2                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	movl	%ebx, %r14d
	.loc	1 58 9                          # driver.c:58:9
	je	.LBB2_10
	jmp	.LBB2_5
	.p2align	4, 0x90
.LBB2_4:                                #   in Loop: Header=BB2_2 Depth=1
	xorl	%ebp, %ebp
.LBB2_5:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %ebx
	imull	%r15d, %ebx
	.p2align	4, 0x90
.LBB2_6:                                #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 59 28                         # driver.c:59:28
	vcvtsi2sd	%ebx, %xmm3, %xmm0
	.loc	1 59 34 is_stmt 0               # driver.c:59:34
	vaddsd	%xmm2, %xmm0, %xmm0
	.loc	1 59 23                         # driver.c:59:23
	vzeroupper
	callq	fmod@PLT
	vmovsd	.LCPI2_1(%rip), %xmm1           # xmm1 = mem[0],zero
	movq	%r13, %rax
	vmovupd	16(%rsp), %xmm2                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 21                         # driver.c:59:21
	vmovsd	%xmm0, (%r12,%rbp,8)
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	incq	%rbp
	addl	%r15d, %ebx
	cmpq	%rbp, %r13
	jne	.LBB2_6
	jmp	.LBB2_10
.LBB2_11:
	.loc	1 67 1                          # driver.c:67:1
	addq	$168, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.Ltmp3:
.Lfunc_end2:
	.size	init_matrix, .Lfunc_end2-init_matrix
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0                          # -- Begin function init_vector
.LCPI3_0:
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
.LCPI3_1:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI3_2:
	.quad	0x4024000000000000              #  10
	.text
	.globl	init_vector
	.p2align	4, 0x90
	.type	init_vector,@function
init_vector:                            # 
.Lfunc_begin3:
	.loc	1 71 0                          # driver.c:71:0
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$376, %rsp                      # imm = 0x178
	.cfi_def_cfa_offset 416
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	.loc	1 74 19 prologue_end            # driver.c:74:19
	testl	%edi, %edi
	.loc	1 74 5 is_stmt 0                # driver.c:74:5
	jle	.LBB3_7
# %bb.1:
	movq	%rsi, %r15
	vmovapd	%xmm0, %xmm1
	.loc	1 74 19                         # driver.c:74:19
	movl	%edi, %r14d
	movl	$4294967280, %r12d              # imm = 0xFFFFFFF0
	.loc	1 74 5                          # driver.c:74:5
	andq	%r14, %r12
	vmovupd	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	je	.LBB3_2
# %bb.3:
	.loc	1 75 23 is_stmt 1               # driver.c:75:23
	vmovddup	%xmm1, %xmm0                    # xmm0 = xmm1[0,0]
	vinsertf128	$1, %xmm0, %ymm0, %ymm0
	vmovupd	%ymm0, 336(%rsp)                # 32-byte Spill
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
	.loc	1 75 21 is_stmt 0               # driver.c:75:21
	vmovd	%ebx, %xmm0
	vpshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	vinsertf128	$1, %xmm0, %ymm0, %ymm0
	vorps	.LCPI3_1(%rip), %ymm0, %ymm1
	vextractf128	$1, %ymm1, %xmm2
	vcvtdq2pd	%xmm2, %ymm2
	vcvtdq2pd	%xmm1, %ymm1
	vorps	.LCPI3_0(%rip), %ymm0, %ymm0
	vextractf128	$1, %ymm0, %xmm3
	vcvtdq2pd	%xmm3, %ymm3
	vcvtdq2pd	%xmm0, %ymm0
	vmovupd	336(%rsp), %ymm4                # 32-byte Reload
	.loc	1 75 23                         # driver.c:75:23
	vaddpd	%ymm0, %ymm4, %ymm0
	vmovupd	%ymm0, 128(%rsp)                # 32-byte Spill
	vaddpd	%ymm3, %ymm4, %ymm0
	vmovupd	%ymm0, 96(%rsp)                 # 32-byte Spill
	vaddpd	%ymm1, %ymm4, %ymm0
	vmovupd	%ymm0, 64(%rsp)                 # 32-byte Spill
	vaddpd	%ymm2, %ymm4, %ymm0
	vmovupd	%ymm0, 160(%rsp)                # 32-byte Spill
	.loc	1 75 16                         # driver.c:75:16
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 320(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 304(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 32(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 160(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	32(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 32(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 64(%rsp), %xmm0     # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 288(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rsp), %ymm0                 # 32-byte Reload
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 272(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rsp), %ymm0                 # 32-byte Reload
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 16(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	16(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 16(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 96(%rsp), %xmm0     # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 256(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 240(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 128(%rsp), %xmm0    # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 224(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 208(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 128(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 192(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 75 14                         # driver.c:75:14
	vunpcklpd	192(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 80(%r15,%rbx,8)
	vmovups	208(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	224(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 64(%r15,%rbx,8)
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	96(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 112(%r15,%rbx,8)
	vmovups	240(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	256(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 96(%r15,%rbx,8)
	vmovups	16(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	64(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 16(%r15,%rbx,8)
	vmovups	272(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	288(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, (%r15,%rbx,8)
	vmovups	32(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	160(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 48(%r15,%rbx,8)
	vmovupd	304(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	320(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovupd	%xmm0, 32(%r15,%rbx,8)
	.loc	1 74 19 is_stmt 1               # driver.c:74:19
	addq	$16, %rbx
	cmpq	%r12, %rbx
	.loc	1 74 5 is_stmt 0                # driver.c:74:5
	jb	.LBB3_4
# %bb.5:
	cmpq	%r14, %r12
	vmovupd	48(%rsp), %xmm1                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	jne	.LBB3_6
	jmp	.LBB3_7
.LBB3_2:
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB3_6:                                # =>This Inner Loop Header: Depth=1
	.loc	1 75 21 is_stmt 1               # driver.c:75:21
	vcvtsi2sd	%r12d, %xmm5, %xmm0
	.loc	1 75 23 is_stmt 0               # driver.c:75:23
	vaddsd	%xmm1, %xmm0, %xmm0
	.loc	1 75 16                         # driver.c:75:16
	vmovsd	.LCPI3_2(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	48(%rsp), %xmm1                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 75 14                         # driver.c:75:14
	vmovsd	%xmm0, (%r15,%r12,8)
	.loc	1 74 19 is_stmt 1               # driver.c:74:19
	incq	%r12
	cmpq	%r12, %r14
	.loc	1 74 5 is_stmt 0                # driver.c:74:5
	jne	.LBB3_6
.LBB3_7:
	.loc	1 80 1 is_stmt 1                # driver.c:80:1
	addq	$376, %rsp                      # imm = 0x178
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Ltmp4:
.Lfunc_end3:
	.size	init_vector, .Lfunc_end3-init_vector
	.cfi_endproc
                                        # -- End function
	.globl	printsum                        # -- Begin function printsum
	.p2align	4, 0x90
	.type	printsum,@function
printsum:                               # 
.Lfunc_begin4:
	.loc	1 84 0                          # driver.c:84:0
	.cfi_startproc
# %bb.0:
	.loc	1 88 16 prologue_end            # driver.c:88:16
	testl	%edi, %edi
	.loc	1 88 5 is_stmt 0                # driver.c:88:5
	jle	.LBB4_1
# %bb.2:
	.loc	1 88 16                         # driver.c:88:16
	movl	%edi, %eax
	movl	$4294967294, %ecx               # imm = 0xFFFFFFFE
	.loc	1 88 5                          # driver.c:88:5
	andq	%rax, %rcx
	je	.LBB4_3
# %bb.4:
	vxorpd	%xmm0, %xmm0, %xmm0
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB4_5:                                # =>This Inner Loop Header: Depth=1
	.loc	1 88 34                         # driver.c:88:34
	vaddpd	(%rsi,%rdx,8), %xmm0, %xmm0
	.loc	1 88 16                         # driver.c:88:16
	addq	$2, %rdx
	cmpq	%rcx, %rdx
	.loc	1 88 5                          # driver.c:88:5
	jb	.LBB4_5
# %bb.6:
	.loc	1 88 34                         # driver.c:88:34
	vpermilpd	$1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
	vaddsd	%xmm1, %xmm0, %xmm0
	.loc	1 88 5                          # driver.c:88:5
	cmpq	%rax, %rcx
	jne	.LBB4_7
	jmp	.LBB4_8
.LBB4_1:
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB4_8
.LBB4_3:
	xorl	%ecx, %ecx
	vxorpd	%xmm0, %xmm0, %xmm0
	.p2align	4, 0x90
.LBB4_7:                                # =>This Inner Loop Header: Depth=1
	.loc	1 88 34                         # driver.c:88:34
	vaddsd	(%rsi,%rcx,8), %xmm0, %xmm0
	.loc	1 88 16                         # driver.c:88:16
	incq	%rcx
	cmpq	%rcx, %rax
	.loc	1 88 5                          # driver.c:88:5
	jne	.LBB4_7
.LBB4_8:
	.loc	1 90 5 is_stmt 1                # driver.c:90:5
	movl	$.L.str, %edi
	movb	$1, %al
	jmp	printf                          # TAILCALL
.Ltmp5:
.Lfunc_end4:
	.size	printsum, .Lfunc_end4-printsum
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function main
.LCPI5_0:
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
.LCPI5_1:
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
.LCPI5_2:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
.LCPI5_3:
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
.LCPI5_6:
	.long	24                              # 0x18
	.long	25                              # 0x19
	.long	26                              # 0x1a
	.long	27                              # 0x1b
.LCPI5_7:
	.long	28                              # 0x1c
	.long	29                              # 0x1d
	.long	30                              # 0x1e
	.long	31                              # 0x1f
.LCPI5_8:
	.long	16                              # 0x10
	.long	17                              # 0x11
	.long	18                              # 0x12
	.long	19                              # 0x13
.LCPI5_9:
	.long	20                              # 0x14
	.long	21                              # 0x15
	.long	22                              # 0x16
	.long	23                              # 0x17
.LCPI5_10:
	.long	40                              # 0x28
	.long	41                              # 0x29
	.long	42                              # 0x2a
	.long	43                              # 0x2b
.LCPI5_11:
	.long	44                              # 0x2c
	.long	45                              # 0x2d
	.long	46                              # 0x2e
	.long	47                              # 0x2f
.LCPI5_12:
	.long	32                              # 0x20
	.long	33                              # 0x21
	.long	34                              # 0x22
	.long	35                              # 0x23
.LCPI5_13:
	.long	36                              # 0x24
	.long	37                              # 0x25
	.long	38                              # 0x26
	.long	39                              # 0x27
.LCPI5_20:
	.quad	0x4008000000000000              #  3
	.quad	0x4010000000000000              #  4
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0
.LCPI5_4:
	.quad	0x3ff0000000000000              #  1
	.quad	0x3ff0000000000000              #  1
	.quad	0x3ff0000000000000              #  1
	.quad	0x3ff0000000000000              #  1
.LCPI5_15:
	.quad	0x4008000000000000              #  3
	.quad	0x4010000000000000              #  4
	.quad	0x4014000000000000              #  5
	.quad	0x4018000000000000              #  6
.LCPI5_16:
	.quad	0x401c000000000000              #  7
	.quad	0x4020000000000000              #  8
	.quad	0x4022000000000000              #  9
	.quad	0x0000000000000000              #  0
.LCPI5_17:
	.quad	0x3ff0000000000000              #  1
	.quad	0x4000000000000000              #  2
	.quad	0x4008000000000000              #  3
	.quad	0x4010000000000000              #  4
.LCPI5_18:
	.quad	0x4014000000000000              #  5
	.quad	0x4018000000000000              #  6
	.quad	0x401c000000000000              #  7
	.quad	0x4020000000000000              #  8
.LCPI5_19:
	.quad	0x4022000000000000              #  9
	.quad	0x0000000000000000              #  0
	.quad	0x3ff0000000000000              #  1
	.quad	0x4000000000000000              #  2
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI5_5:
	.quad	0x4024000000000000              #  10
.LCPI5_14:
	.quad	0x3ff0000000000000              #  1
.LCPI5_21:
	.quad	0x3eb0c6f7a0b5ed8d              #  9.9999999999999995E-7
.LCPI5_22:
	.quad	0x402020c49ba5e354              #  8.064
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # 
.Lfunc_begin5:
	.loc	1 99 0                          # driver.c:99:0
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$34176, %rsp                    # imm = 0x8580
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	$71658, %esi                    # imm = 0x117EA
	movl	$3, %edi
	callq	__intel_new_feature_proc_init@PLT
.Ltmp6:
	.loc	1 106 30 prologue_end           # driver.c:106:30
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 832(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 800(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 768(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 736(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 704(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 672(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 640(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 608(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 576(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 544(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 512(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 480(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 448(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 416(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 384(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 352(%rsp)                # AlignMOV convert to UnAlignMOV 
	.loc	1 107 30                        # driver.c:107:30
	vmovupd	%ymm0, 1856(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1824(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1792(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1760(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1728(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1696(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1664(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1632(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1600(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1568(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1536(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1504(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1472(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1440(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1408(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm0, 1376(%rsp)               # AlignMOV convert to UnAlignMOV 
	xorl	%r14d, %r14d
	.loc	1 110 5                         # driver.c:110:5
	movl	$.L.str.1, %edi
	movl	$64, %esi
	movl	$63, %edx
	xorl	%eax, %eax
	vzeroupper
	callq	printf
	leaq	1888(%rsp), %r13
	vmovdqu	.LCPI5_2(%rip), %xmm2           # xmm2 = [0,1,2,3]
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB5_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_2 Depth 2
                                        #     Child Loop BB5_4 Depth 2
.Ltmp7:
	.loc	1 59 28                         # driver.c:59:28
	vmovd	%r15d, %xmm0
	vpshufd	$0, %xmm0, %xmm4                # xmm4 = xmm0[0,0,0,0]
	vmovdqu	%xmm4, 336(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpmulld	.LCPI5_1(%rip), %xmm4, %xmm0
	vpmulld	%xmm2, %xmm4, %xmm3
	vpmulld	.LCPI5_3(%rip), %xmm4, %xmm2
	vcvtdq2pd	%xmm2, %ymm2
	vcvtdq2pd	%xmm3, %ymm5
	vcvtdq2pd	%xmm0, %ymm0
	vpmulld	.LCPI5_0(%rip), %xmm4, %xmm3
	vcvtdq2pd	%xmm3, %ymm3
	vmovupd	.LCPI5_4(%rip), %ymm4           # ymm4 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 34 is_stmt 0               # driver.c:59:34
	vaddpd	%ymm4, %ymm3, %ymm3
	vmovupd	%ymm3, (%rsp)                   # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm0, %ymm0
	vmovupd	%ymm0, 128(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm5, %ymm0
	vmovupd	%ymm0, 96(%rsp)                 # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm2, %ymm0
	vmovupd	%ymm0, 160(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 23                         # driver.c:59:23
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 320(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 304(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 160(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 96(%rsp), %xmm0     # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 288(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 272(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 128(%rsp), %xmm0    # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 256(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 240(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 128(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, (%rsp), %xmm0       # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 224(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 208(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 192(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 59 21                         # driver.c:59:21
	vunpcklpd	192(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	.loc	1 59 13                         # driver.c:59:13
	imulq	$504, %r15, %r12                # imm = 0x1F8
	.loc	1 59 21                         # driver.c:59:21
	vmovups	%xmm0, 1968(%rsp,%r12)
	vmovups	208(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	224(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1952(%rsp,%r12)
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	128(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2000(%rsp,%r12)
	vmovups	240(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	256(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1984(%rsp,%r12)
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	96(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1904(%rsp,%r12)
	vmovups	272(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	288(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1888(%rsp,%r12)
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	160(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1936(%rsp,%r12)
	vmovups	304(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	320(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 1920(%rsp,%r12)
	vmovdqu	336(%rsp), %xmm3                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 28                         # driver.c:59:28
	vpmulld	.LCPI5_7(%rip), %xmm3, %xmm0
	vpmulld	.LCPI5_8(%rip), %xmm3, %xmm1
	vpmulld	.LCPI5_9(%rip), %xmm3, %xmm2
	vcvtdq2pd	%xmm2, %ymm2
	vcvtdq2pd	%xmm1, %ymm1
	vcvtdq2pd	%xmm0, %ymm0
	vpmulld	.LCPI5_6(%rip), %xmm3, %xmm3
	vcvtdq2pd	%xmm3, %ymm3
	vmovupd	.LCPI5_4(%rip), %ymm4           # ymm4 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 34                         # driver.c:59:34
	vaddpd	%ymm4, %ymm3, %ymm3
	vmovupd	%ymm3, (%rsp)                   # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm0, %ymm0
	vmovupd	%ymm0, 128(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm1, %ymm0
	vmovupd	%ymm0, 96(%rsp)                 # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm2, %ymm0
	vmovupd	%ymm0, 160(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 23                         # driver.c:59:23
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 320(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 304(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 160(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 96(%rsp), %xmm0     # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 288(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 272(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 128(%rsp), %xmm0    # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 256(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 240(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 128(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, (%rsp), %xmm0       # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 224(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 208(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 192(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 59 21                         # driver.c:59:21
	vunpcklpd	192(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2096(%rsp,%r12)
	vmovups	208(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	224(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2080(%rsp,%r12)
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	128(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2128(%rsp,%r12)
	vmovups	240(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	256(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2112(%rsp,%r12)
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	96(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2032(%rsp,%r12)
	vmovups	272(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	288(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2016(%rsp,%r12)
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	160(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2064(%rsp,%r12)
	vmovups	304(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	320(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2048(%rsp,%r12)
	vmovdqu	336(%rsp), %xmm3                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 28                         # driver.c:59:28
	vpmulld	.LCPI5_11(%rip), %xmm3, %xmm0
	vpmulld	.LCPI5_12(%rip), %xmm3, %xmm1
	vpmulld	.LCPI5_13(%rip), %xmm3, %xmm2
	vcvtdq2pd	%xmm2, %ymm2
	vcvtdq2pd	%xmm1, %ymm1
	vcvtdq2pd	%xmm0, %ymm0
	vpmulld	.LCPI5_10(%rip), %xmm3, %xmm3
	vcvtdq2pd	%xmm3, %ymm3
	vmovupd	.LCPI5_4(%rip), %ymm4           # ymm4 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 34                         # driver.c:59:34
	vaddpd	%ymm4, %ymm3, %ymm3
	vmovupd	%ymm3, (%rsp)                   # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm0, %ymm0
	vmovupd	%ymm0, 128(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm1, %ymm0
	vmovupd	%ymm0, 96(%rsp)                 # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vaddpd	%ymm4, %ymm2, %ymm0
	vmovupd	%ymm0, 160(%rsp)                # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 23                         # driver.c:59:23
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 320(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 304(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	160(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 160(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 96(%rsp), %xmm0     # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 288(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 272(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	96(%rsp), %ymm0                 # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, 128(%rsp), %xmm0    # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 256(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 240(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	128(%rsp), %ymm0                # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 128(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovups	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, (%rsp), %xmm0       # 16-byte Folded Reload
                                        # xmm0 = mem[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	vmovupd	%xmm0, 224(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 208(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 192(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 59 21                         # driver.c:59:21
	vunpcklpd	192(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2224(%rsp,%r12)
	vmovups	208(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	224(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2208(%rsp,%r12)
	vmovups	48(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	128(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2256(%rsp,%r12)
	vmovups	240(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	256(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2240(%rsp,%r12)
	vmovups	64(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	96(%rsp), %xmm0, %xmm0  # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2160(%rsp,%r12)
	vmovups	272(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	288(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2144(%rsp,%r12)
	vmovups	80(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	160(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2192(%rsp,%r12)
	vmovups	304(%rsp), %xmm0                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	320(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 2176(%rsp,%r12)
	movl	$48, %ebx
	.p2align	4, 0x90
.LBB5_2:                                #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 59 28                         # driver.c:59:28
	vmovd	%ebx, %xmm0
	vpshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	vpor	.LCPI5_2(%rip), %xmm0, %xmm0
	vpmulld	336(%rsp), %xmm0, %xmm0         # 16-byte Folded Reload
	vcvtdq2pd	%xmm0, %ymm0
	.loc	1 59 34                         # driver.c:59:34
	vaddpd	.LCPI5_4(%rip), %ymm0, %ymm0
	vmovupd	%ymm0, (%rsp)                   # 32-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 59 23                         # driver.c:59:23
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 128(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
                                        # kill: def $xmm0 killed $xmm0 killed $ymm0
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovups	%xmm0, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %ymm0                   # 32-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovupd	%xmm0, (%rsp)                   # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	vzeroupper
	callq	fmod@PLT
	vmovupd	%xmm0, 160(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %xmm0                   # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 59 21                         # driver.c:59:21
	vunpcklpd	160(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovups	%xmm0, 16(%r13,%rbx,8)
	vmovupd	96(%rsp), %xmm0                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vunpcklpd	128(%rsp), %xmm0, %xmm0 # 16-byte Folded Reload
                                        # xmm0 = xmm0[0],mem[0]
	vmovupd	%xmm0, (%r13,%rbx,8)
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	leaq	4(%rbx), %rax
	cmpq	$56, %rbx
	movq	%rax, %rbx
	.loc	1 58 9 is_stmt 0                # driver.c:58:9
	jb	.LBB5_2
# %bb.3:                                #   in Loop: Header=BB5_1 Depth=1
	movl	$60, %ebx
	movl	%r14d, %r12d
	.p2align	4, 0x90
.LBB5_4:                                #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 59 28 is_stmt 1               # driver.c:59:28
	vcvtsi2sd	%r12d, %xmm2, %xmm0
	.loc	1 59 34 is_stmt 0               # driver.c:59:34
	vaddsd	.LCPI5_14(%rip), %xmm0, %xmm0
	.loc	1 59 23                         # driver.c:59:23
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	callq	fmod@PLT
	.loc	1 59 21                         # driver.c:59:21
	vmovsd	%xmm0, (%r13,%rbx,8)
	.loc	1 58 23 is_stmt 1               # driver.c:58:23
	incq	%rbx
	addl	%r15d, %r12d
	cmpq	$63, %rbx
	.loc	1 58 9 is_stmt 0                # driver.c:58:9
	jne	.LBB5_4
# %bb.5:                                #   in Loop: Header=BB5_1 Depth=1
	.loc	1 57 19 is_stmt 1               # driver.c:57:19
	leaq	1(%r15), %rax
	.loc	1 57 5 is_stmt 0                # driver.c:57:5
	addq	$504, %r13                      # imm = 0x1F8
	addl	$60, %r14d
	.loc	1 57 19                         # driver.c:57:19
	cmpq	$63, %r15
	movq	%rax, %r15
	vmovdqu	.LCPI5_2(%rip), %xmm2           # xmm2 = [0,1,2,3]
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI5_5(%rip), %xmm1           # xmm1 = mem[0],zero
	.loc	1 57 5                          # driver.c:57:5
	jne	.LBB5_1
.Ltmp8:
# %bb.6:
	.loc	1 75 14 is_stmt 1               # driver.c:75:14
	vmovups	.LCPI5_15(%rip), %ymm0          # ymm0 = [3.0E+0,4.0E+0,5.0E+0,6.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm0, 864(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovups	.LCPI5_16(%rip), %ymm1          # ymm1 = [7.0E+0,8.0E+0,9.0E+0,0.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm1, 896(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovups	.LCPI5_17(%rip), %ymm2          # ymm2 = [1.0E+0,2.0E+0,3.0E+0,4.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm2, 928(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovups	.LCPI5_18(%rip), %ymm3          # ymm3 = [5.0E+0,6.0E+0,7.0E+0,8.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm3, 960(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovups	.LCPI5_19(%rip), %ymm4          # ymm4 = [9.0E+0,0.0E+0,1.0E+0,2.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm4, 992(%rsp)                # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm0, 1024(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm1, 1056(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm2, 1088(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm3, 1120(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm4, 1152(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm0, 1184(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm1, 1216(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm2, 1248(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm3, 1280(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm4, 1312(%rsp)               # AlignMOV convert to UnAlignMOV 
	vmovupd	.LCPI5_20(%rip), %xmm0          # xmm0 = [3.0E+0,4.0E+0]
                                        # AlignMOV convert to UnAlignMOV 
	vmovupd	%xmm0, 1344(%rsp)               # AlignMOV convert to UnAlignMOV 
	movabsq	$4617315517961601024, %rax      # imm = 0x4014000000000000
	movq	%rax, 1360(%rsp)
.Ltmp9:
	.loc	1 34 5                          # driver.c:34:5
	movl	$tstart, %edi
	xorl	%esi, %esi
	vzeroupper
	callq	gettimeofday
	movl	$1000000, %ebx                  # imm = 0xF4240
	leaq	1888(%rsp), %r14
	leaq	352(%rsp), %r15
	leaq	864(%rsp), %r12
	leaq	1376(%rsp), %r13
.Ltmp10:
	.p2align	4, 0x90
.LBB5_7:                                # =>This Inner Loop Header: Depth=1
	.loc	1 119 9                         # driver.c:119:9
	movl	$64, %edi
	movl	$63, %esi
	movq	%r14, %rdx
	movq	%r15, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	callq	matvec
	.loc	1 118 19                        # driver.c:118:19
	decl	%ebx
	.loc	1 118 5 is_stmt 0               # driver.c:118:5
	jne	.LBB5_7
# %bb.8:
.Ltmp11:
	.loc	1 43 5 is_stmt 1                # driver.c:43:5
	movl	$tstop, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	.loc	1 44 13                         # driver.c:44:13
	vcvtsi2sdq	tstop(%rip), %xmm5, %xmm0
	.loc	1 44 28 is_stmt 0               # driver.c:44:28
	vcvtsi2sdq	tstop+8(%rip), %xmm5, %xmm1
	.loc	1 45 13 is_stmt 1               # driver.c:45:13
	vcvtsi2sdq	tstart(%rip), %xmm5, %xmm2
	.loc	1 44 26                         # driver.c:44:26
	vsubsd	%xmm2, %xmm0, %xmm0
	.loc	1 45 29                         # driver.c:45:29
	vcvtsi2sdq	tstart+8(%rip), %xmm5, %xmm2
	vsubsd	%xmm2, %xmm1, %xmm1
	vmulsd	.LCPI5_21(%rip), %xmm1, %xmm1
	.loc	1 44 55                         # driver.c:44:55
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
.Ltmp12:
	.loc	1 124 5                         # driver.c:124:5
	movl	$.L.str.2, %edi
	movb	$1, %al
	callq	printf
	vmovsd	.LCPI5_22(%rip), %xmm0          # xmm0 = mem[0],zero
	.loc	1 127 44                        # driver.c:127:44
	vdivsd	(%rsp), %xmm0, %xmm0            # 8-byte Folded Reload
	.loc	1 125 5                         # driver.c:125:5
	movl	$.L.str.3, %edi
	movb	$1, %al
	callq	printf
.Ltmp13:
	.loc	1 88 37                         # driver.c:88:37
	vmovupd	368(%rsp), %xmm0                # AlignMOV convert to UnAlignMOV 
	.loc	1 88 34 is_stmt 0               # driver.c:88:34
	vaddpd	352(%rsp), %xmm0, %xmm0
	vaddpd	384(%rsp), %xmm0, %xmm0
	vaddpd	400(%rsp), %xmm0, %xmm0
	vaddpd	416(%rsp), %xmm0, %xmm0
	vaddpd	432(%rsp), %xmm0, %xmm0
	vaddpd	448(%rsp), %xmm0, %xmm0
	vaddpd	464(%rsp), %xmm0, %xmm0
	vaddpd	480(%rsp), %xmm0, %xmm0
	vaddpd	496(%rsp), %xmm0, %xmm0
	vaddpd	512(%rsp), %xmm0, %xmm0
	vaddpd	528(%rsp), %xmm0, %xmm0
	vaddpd	544(%rsp), %xmm0, %xmm0
	vaddpd	560(%rsp), %xmm0, %xmm0
	vaddpd	576(%rsp), %xmm0, %xmm0
	vaddpd	592(%rsp), %xmm0, %xmm0
	vaddpd	608(%rsp), %xmm0, %xmm0
	vaddpd	624(%rsp), %xmm0, %xmm0
	vaddpd	640(%rsp), %xmm0, %xmm0
	vaddpd	656(%rsp), %xmm0, %xmm0
	vaddpd	672(%rsp), %xmm0, %xmm0
	vaddpd	688(%rsp), %xmm0, %xmm0
	vaddpd	704(%rsp), %xmm0, %xmm0
	vaddpd	720(%rsp), %xmm0, %xmm0
	vaddpd	736(%rsp), %xmm0, %xmm0
	vaddpd	752(%rsp), %xmm0, %xmm0
	vaddpd	768(%rsp), %xmm0, %xmm0
	vaddpd	784(%rsp), %xmm0, %xmm0
	vaddpd	800(%rsp), %xmm0, %xmm0
	vaddpd	816(%rsp), %xmm0, %xmm0
	vaddpd	832(%rsp), %xmm0, %xmm0
	vaddpd	848(%rsp), %xmm0, %xmm0
	vpermilpd	$1, %xmm0, %xmm1        # xmm1 = xmm0[1,0]
	vaddsd	%xmm1, %xmm0, %xmm0
	.loc	1 90 5 is_stmt 1                # driver.c:90:5
	movl	$.L.str, %edi
	movb	$1, %al
	callq	printf
.Ltmp14:
	.loc	1 130 5                         # driver.c:130:5
	xorl	%eax, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Ltmp15:
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
	.cfi_endproc
                                        # -- End function
	.type	tstart,@object                  # 
	.local	tstart
	.comm	tstart,16,8
	.type	tstop,@object                   # 
	.local	tstop
	.comm	tstop,16,8
	.type	.L.str,@object                  # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Sum of result = %f\n"
	.size	.L.str, 20

	.type	inc_i,@object                   # 
	.data
	.globl	inc_i
	.p2align	2, 0x0
inc_i:
	.long	1                               # 0x1
	.size	inc_i, 4

	.type	inc_j,@object                   # 
	.globl	inc_j
	.p2align	2, 0x0
inc_j:
	.long	1                               # 0x1
	.size	inc_j, 4

	.type	.L.str.1,@object                # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"ROW: %d COL: %d\n"
	.size	.L.str.1, 17

	.type	.L.str.2,@object                # 
.L.str.2:
	.asciz	"Elapsed time = %lf seconds\n"
	.size	.L.str.2, 28

	.type	.L.str.3,@object                # 
.L.str.3:
	.asciz	"GigaFlops = %f\n"
	.size	.L.str.3, 16

	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.ascii	"\201v"                         # DW_AT_INTEL_comp_flags
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	32                              # DW_AT_inline
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	29                              # DW_TAG_inlined_subroutine
	.byte	0                               # DW_CHILDREN_no
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	88                              # DW_AT_call_file
	.byte	11                              # DW_FORM_data1
	.byte	89                              # DW_AT_call_line
	.byte	11                              # DW_FORM_data1
	.byte	87                              # DW_AT_call_column
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	4                               # DWARF version number
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0xb8 DW_TAG_compile_unit
	.long	.Linfo_string0                  # DW_AT_producer
	.long	.Linfo_string1                  # DW_AT_INTEL_comp_flags
	.short	12                              # DW_AT_language
	.long	.Linfo_string2                  # DW_AT_name
	.long	.Lline_table_start0             # DW_AT_stmt_list
	.long	.Linfo_string3                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end5-.Lfunc_begin0       # DW_AT_high_pc
	.byte	2                               # Abbrev [2] 0x2e:0x6 DW_TAG_subprogram
	.long	.Linfo_string4                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	2                               # Abbrev [2] 0x34:0x6 DW_TAG_subprogram
	.long	.Linfo_string5                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	2                               # Abbrev [2] 0x3a:0x6 DW_TAG_subprogram
	.long	.Linfo_string6                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	2                               # Abbrev [2] 0x40:0x6 DW_TAG_subprogram
	.long	.Linfo_string7                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	2                               # Abbrev [2] 0x46:0x6 DW_TAG_subprogram
	.long	.Linfo_string8                  # DW_AT_name
	.byte	1                               # DW_AT_inline
	.byte	3                               # Abbrev [3] 0x4c:0x76 DW_TAG_subprogram
	.quad	.Lfunc_begin5                   # DW_AT_low_pc
	.long	.Lfunc_end5-.Lfunc_begin5       # DW_AT_high_pc
	.long	.Linfo_string9                  # DW_AT_name
	.byte	4                               # Abbrev [4] 0x5d:0x14 DW_TAG_inlined_subroutine
	.long	46                              # DW_AT_abstract_origin
	.quad	.Ltmp7                          # DW_AT_low_pc
	.long	.Ltmp8-.Ltmp7                   # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	113                             # DW_AT_call_line
	.byte	5                               # DW_AT_call_column
	.byte	4                               # Abbrev [4] 0x71:0x14 DW_TAG_inlined_subroutine
	.long	52                              # DW_AT_abstract_origin
	.quad	.Ltmp8                          # DW_AT_low_pc
	.long	.Ltmp9-.Ltmp8                   # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	114                             # DW_AT_call_line
	.byte	5                               # DW_AT_call_column
	.byte	4                               # Abbrev [4] 0x85:0x14 DW_TAG_inlined_subroutine
	.long	58                              # DW_AT_abstract_origin
	.quad	.Ltmp9                          # DW_AT_low_pc
	.long	.Ltmp10-.Ltmp9                  # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	117                             # DW_AT_call_line
	.byte	5                               # DW_AT_call_column
	.byte	4                               # Abbrev [4] 0x99:0x14 DW_TAG_inlined_subroutine
	.long	64                              # DW_AT_abstract_origin
	.quad	.Ltmp11                         # DW_AT_low_pc
	.long	.Ltmp12-.Ltmp11                 # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	121                             # DW_AT_call_line
	.byte	16                              # DW_AT_call_column
	.byte	4                               # Abbrev [4] 0xad:0x14 DW_TAG_inlined_subroutine
	.long	70                              # DW_AT_abstract_origin
	.quad	.Ltmp13                         # DW_AT_low_pc
	.long	.Ltmp14-.Ltmp13                 # DW_AT_high_pc
	.byte	1                               # DW_AT_call_file
	.byte	128                             # DW_AT_call_line
	.byte	5                               # DW_AT_call_column
	.byte	0                               # End Of Children Mark
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang based Intel(R) oneAPI DPC++/C++ Compiler 2023.0.0 (2023.0.0.20221201)" # string offset=0
.Linfo_string1:
	.asciz	" --intel -O2 -x avx multiply.c driver.c -S -qopt-report=3 -fargument-noalias -fveclib=SVML -fheinous-gnu-extensions" # string offset=76
.Linfo_string2:
	.asciz	"driver.c"                      # string offset=192
.Linfo_string3:
	.asciz	"/home/u166450/practice8/compiler-optimization/vectorization/matvector/c/solutions/align" # string offset=201
.Linfo_string4:
	.asciz	"init_matrix"                   # string offset=289
.Linfo_string5:
	.asciz	"init_vector"                   # string offset=301
.Linfo_string6:
	.asciz	"start_timer"                   # string offset=313
.Linfo_string7:
	.asciz	"stop_timer"                    # string offset=325
.Linfo_string8:
	.asciz	"printsum"                      # string offset=336
.Linfo_string9:
	.asciz	"main"                          # string offset=345
	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2023.0.0 (2023.0.0.20221201)"
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
