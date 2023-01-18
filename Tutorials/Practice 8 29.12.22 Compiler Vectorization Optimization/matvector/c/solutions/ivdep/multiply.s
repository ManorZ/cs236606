	.text
	.file	"multiply.c"
	.globl	matvec                          # -- Begin function matvec
	.p2align	4, 0x90
	.type	matvec,@function
matvec:                                 # 
.Lfunc_begin0:
	.file	1 "/home/u166450/practice8/compiler-optimization/vectorization/matvector/c/solutions/ivdep" "multiply.c"
	.loc	1 19 0                          # multiply.c:19:0
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
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	.loc	1 31 19 prologue_end            # multiply.c:31:19
	testl	%edi, %edi
	.loc	1 31 5 is_stmt 0                # multiply.c:31:5
	je	.LBB0_21
# %bb.1:
	.loc	1 33 23 is_stmt 1               # multiply.c:33:23
	testl	%esi, %esi
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	je	.LBB0_21
# %bb.2:
	movq	%r9, %r12
	movq	%r8, -104(%rsp)                 # 8-byte Spill
	movl	%esi, %eax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	.loc	1 31 19 is_stmt 1               # multiply.c:31:19
	movslq	%edi, %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	.loc	1 33 23                         # multiply.c:33:23
	movslq	%esi, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	cmpl	$8, %edi
	jae	.LBB0_3
.LBB0_12:
	movq	-96(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %rdi
	andq	$-8, %rdi
	cmpq	%rax, %rdi
	movq	-112(%rsp), %rbx                # 8-byte Reload
	movq	-120(%rsp), %r10                # 8-byte Reload
	movq	-104(%rsp), %rbp                # 8-byte Reload
	jae	.LBB0_21
# %bb.13:
	leaq	-1(%rax), %r8
	.loc	1 31 5 is_stmt 1                # multiply.c:31:5
	movq	%rbx, %rsi
	andq	$-2, %rsi
	.loc	1 33 9                          # multiply.c:33:9
	shrq	$3, %rax
	imulq	%r10, %rax
	shlq	$6, %rax
	addq	%rax, %rdx
	shlq	$3, %r10
	jmp	.LBB0_14
	.p2align	4, 0x90
.LBB0_20:                               #   in Loop: Header=BB0_14 Depth=1
	.loc	1 34 18                         # multiply.c:34:18
	vmovsd	%xmm0, (%rcx,%rdi,8)
	.loc	1 31 19                         # multiply.c:31:19
	leaq	1(%rdi), %rax
	.loc	1 31 5 is_stmt 0                # multiply.c:31:5
	addq	%r10, %rdx
	.loc	1 31 19                         # multiply.c:31:19
	cmpq	%r8, %rdi
	movq	%rax, %rdi
	.loc	1 31 5                          # multiply.c:31:5
	je	.LBB0_21
.LBB0_14:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_18 Depth 2
                                        #     Child Loop BB0_16 Depth 2
	.loc	1 34 38 is_stmt 1               # multiply.c:34:38
	vmovsd	(%r12,%rdi,8), %xmm1            # xmm1 = mem[0],zero
	.loc	1 34 13 is_stmt 0               # multiply.c:34:13
	vmovsd	(%rcx,%rdi,8), %xmm0            # xmm0 = mem[0],zero
	.loc	1 31 5 is_stmt 1                # multiply.c:31:5
	testq	%rsi, %rsi
	.loc	1 33 9                          # multiply.c:33:9
	je	.LBB0_15
# %bb.17:                               #   in Loop: Header=BB0_14 Depth=1
	.loc	1 34 36                         # multiply.c:34:36
	vmovddup	%xmm1, %xmm3                    # xmm3 = xmm1[0,0]
	vxorpd	%xmm2, %xmm2, %xmm2
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_18:                               #   Parent Loop BB0_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 34 31 is_stmt 0               # multiply.c:34:31
	vmovupd	(%rbp,%rax,8), %xmm4
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rdx,%rax,8), %xmm4, %xmm4
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm3, %xmm4, %xmm4
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm2, %xmm4, %xmm2
	.loc	1 33 23 is_stmt 1               # multiply.c:33:23
	addq	$2, %rax
	cmpq	%rsi, %rax
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	jl	.LBB0_18
# %bb.19:                               #   in Loop: Header=BB0_14 Depth=1
	.loc	1 34 18 is_stmt 1               # multiply.c:34:18
	vpermilpd	$1, %xmm2, %xmm3        # xmm3 = xmm2[1,0]
	vaddsd	%xmm3, %xmm2, %xmm2
	vaddsd	%xmm2, %xmm0, %xmm0
	movq	%rsi, %rax
	.loc	1 31 5                          # multiply.c:31:5
	cmpq	%rbx, %rsi
	.loc	1 33 9                          # multiply.c:33:9
	jne	.LBB0_16
	jmp	.LBB0_20
	.p2align	4, 0x90
.LBB0_15:                               #   in Loop: Header=BB0_14 Depth=1
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_16:                               #   Parent Loop BB0_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 34 31                         # multiply.c:34:31
	vmovsd	(%rbp,%rax,8), %xmm2            # xmm2 = mem[0],zero
	.loc	1 34 29 is_stmt 0               # multiply.c:34:29
	vmulsd	(%rdx,%rax,8), %xmm2, %xmm2
	.loc	1 34 36                         # multiply.c:34:36
	vaddsd	%xmm1, %xmm2, %xmm2
	.loc	1 34 18                         # multiply.c:34:18
	vaddsd	%xmm0, %xmm2, %xmm0
	.loc	1 33 23 is_stmt 1               # multiply.c:33:23
	incq	%rax
	cmpq	%rax, %rbx
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	jne	.LBB0_16
	jmp	.LBB0_20
.LBB0_21:
	.loc	1 37 1 is_stmt 1                # multiply.c:37:1
	addq	$248, %rsp
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
.LBB0_3:
	.cfi_def_cfa_offset 304
	movq	-96(%rsp), %rax                 # 8-byte Reload
	.loc	1 31 5                          # multiply.c:31:5
	shrq	$3, %rax
	.loc	1 33 9                          # multiply.c:33:9
	decq	%rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	-112(%rsp), %rbp                # 8-byte Reload
	.loc	1 31 5                          # multiply.c:31:5
	andq	$-2, %rbp
	movq	-120(%rsp), %rax                # 8-byte Reload
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(,%rax,8), %rbx
	leaq	(%rax,%rax), %r9
	leaq	(%rax,%rax,2), %rsi
	leaq	(,%rax,4), %r15
	leaq	(%rax,%rax,4), %r10
	leaq	(%r9,%r9,2), %r13
	movq	%rbx, %r8
	subq	%rax, %r8
	.loc	1 33 9                          # multiply.c:33:9
	shlq	$6, %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	xorl	%edi, %edi
	movq	%rdx, %r11
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	movq	%r9, 8(%rsp)                    # 8-byte Spill
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	movq	%r10, -64(%rsp)                 # 8-byte Spill
	movq	%r13, -72(%rsp)                 # 8-byte Spill
	movq	%r8, -80(%rsp)                  # 8-byte Spill
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_11:                               #   in Loop: Header=BB0_4 Depth=1
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	movq	(%rsp), %rax                    # 8-byte Reload
	.loc	1 34 18                         # multiply.c:34:18
	vmovupd	%xmm10, (%rcx,%rax,8)
	vmovupd	%xmm5, 16(%rcx,%rax,8)
	vmovupd	%xmm7, 32(%rcx,%rax,8)
	vmovupd	%xmm6, 48(%rcx,%rax,8)
	movq	-88(%rsp), %rsi                 # 8-byte Reload
	.loc	1 31 19                         # multiply.c:31:19
	leaq	1(%rsi), %rdi
	.loc	1 31 5 is_stmt 0                # multiply.c:31:5
	addq	-24(%rsp), %r11                 # 8-byte Folded Reload
	.loc	1 31 19                         # multiply.c:31:19
	cmpq	-8(%rsp), %rsi                  # 8-byte Folded Reload
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%r12, %rsi
	movq	%r14, %r15
	movq	-32(%rsp), %r12                 # 8-byte Reload
	.loc	1 31 5                          # multiply.c:31:5
	je	.LBB0_12
.LBB0_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
                                        #     Child Loop BB0_7 Depth 2
	.loc	1 34 38 is_stmt 1               # multiply.c:34:38
	leaq	(,%rdi,8), %r14
	movq	%rdi, %rax
	shlq	$6, %rax
	.loc	1 34 13 is_stmt 0               # multiply.c:34:13
	vmovupd	(%r12,%rax), %xmm8
	vmovupd	16(%r12,%rax), %xmm9
	vmovupd	32(%r12,%rax), %xmm11
	vmovupd	48(%r12,%rax), %xmm12
	.loc	1 34 38                         # multiply.c:34:38
	vmovupd	(%rcx,%rax), %xmm10
	vmovupd	16(%rcx,%rax), %xmm5
	.loc	1 31 5 is_stmt 1                # multiply.c:31:5
	vmovupd	32(%rcx,%rax), %xmm7
	vmovupd	48(%rcx,%rax), %xmm6
	testq	%rbp, %rbp
	movq	%rdi, -88(%rsp)                 # 8-byte Spill
	movq	%r14, (%rsp)                    # 8-byte Spill
	.loc	1 33 9                          # multiply.c:33:9
	je	.LBB0_5
# %bb.8:                                #   in Loop: Header=BB0_4 Depth=1
	vmovupd	%ymm8, 208(%rsp)                # 32-byte Spill
	vmovupd	%xmm9, 32(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 34 13                         # multiply.c:34:13
	vinsertf128	$1, %xmm9, %ymm8, %ymm0
	.loc	1 34 38 is_stmt 0               # multiply.c:34:38
	vinsertf128	$1, %xmm5, %ymm10, %ymm1
	vmovups	%ymm1, 112(%rsp)                # 32-byte Spill
	vmovupd	%ymm11, 176(%rsp)               # 32-byte Spill
	vmovupd	%xmm12, 16(%rsp)                # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 34 13                         # multiply.c:34:13
	vinsertf128	$1, %xmm12, %ymm11, %ymm1
	.loc	1 31 5 is_stmt 1                # multiply.c:31:5
	vinsertf128	$1, %xmm6, %ymm7, %ymm2
	vmovups	%ymm2, 144(%rsp)                # 32-byte Spill
	.loc	1 34 36                         # multiply.c:34:36
	vmovddup	%xmm0, %xmm2                    # xmm2 = xmm0[0,0]
	vmovupd	%xmm2, 96(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$3, %xmm0, %xmm2        # xmm2 = xmm0[1,1]
	vmovupd	%xmm2, 80(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vextractf128	$1, %ymm0, %xmm0
	vmovddup	%xmm0, %xmm2                    # xmm2 = xmm0[0,0]
	vmovupd	%xmm2, 64(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vpermilpd	$3, %xmm0, %xmm0        # xmm0 = xmm0[1,1]
	vmovupd	%xmm0, 48(%rsp)                 # 16-byte Spill
                                        # AlignMOV convert to UnAlignMOV 
	vmovddup	%xmm1, %xmm8                    # xmm8 = xmm1[0,0]
	vpermilpd	$3, %xmm1, %xmm11       # xmm11 = xmm1[1,1]
	vextractf128	$1, %ymm1, %xmm0
	vmovddup	%xmm0, %xmm9                    # xmm9 = xmm0[0,0]
	vpermilpd	$3, %xmm0, %xmm10       # xmm10 = xmm0[1,1]
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm1, %xmm1, %xmm1
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm2, %xmm2, %xmm2
	xorl	%esi, %esi
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm13, %xmm13, %xmm13
	movq	-120(%rsp), %r15                # 8-byte Reload
	movq	-104(%rsp), %rdi                # 8-byte Reload
	.p2align	4, 0x90
.LBB0_9:                                #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	.loc	1 34 31 is_stmt 0               # multiply.c:34:31
	vmovupd	(%rdi,%rsi,8), %xmm14
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%r11,%rsi,8), %rcx
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%r11,%rsi,8), %xmm14, %xmm15
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	96(%rsp), %xmm15, %xmm3         # 16-byte Folded Reload
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm3, %xmm13, %xmm13
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%rcx,%r15,8), %r14
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rcx,%r15,8), %xmm14, %xmm3
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	80(%rsp), %xmm3, %xmm3          # 16-byte Folded Reload
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm3, %xmm12, %xmm12
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm3
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rbx, %r14
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	64(%rsp), %xmm3, %xmm3          # 16-byte Folded Reload
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm2, %xmm3, %xmm2
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm3
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rbx, %r14
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	48(%rsp), %xmm3, %xmm3          # 16-byte Folded Reload
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm4
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm5, %xmm3, %xmm5
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rbx, %r14
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm4, %xmm8, %xmm3
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm1, %xmm3, %xmm1
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm3
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rbx, %r14
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm3, %xmm11, %xmm3
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm7, %xmm3, %xmm7
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm3
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm3, %xmm9, %xmm3
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm0, %xmm3, %xmm0
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rbx, %r14
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	(%rbx,%r14), %xmm14, %xmm3
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm3, %xmm10, %xmm3
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm6, %xmm3, %xmm6
	.loc	1 33 23 is_stmt 1               # multiply.c:33:23
	addq	$2, %rsi
	cmpq	%rbp, %rsi
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	jl	.LBB0_9
# %bb.10:                               #   in Loop: Header=BB0_4 Depth=1
	.loc	1 34 18 is_stmt 1               # multiply.c:34:18
	vpermilpd	$1, %xmm13, %xmm3       # xmm3 = xmm13[1,0]
	vaddsd	%xmm3, %xmm13, %xmm3
	vmovupd	112(%rsp), %ymm9                # 32-byte Reload
	vaddsd	%xmm3, %xmm9, %xmm8
	vpermilpd	$1, %xmm9, %xmm4        # xmm4 = xmm9[1,0]
	vpermilpd	$1, %xmm12, %xmm3       # xmm3 = xmm12[1,0]
	vaddsd	%xmm3, %xmm12, %xmm3
	vaddsd	%xmm3, %xmm4, %xmm3
	vunpcklpd	%xmm3, %xmm8, %xmm10    # xmm10 = xmm8[0],xmm3[0]
	vextractf128	$1, %ymm9, %xmm8
	vpermilpd	$1, %xmm2, %xmm3        # xmm3 = xmm2[1,0]
	vaddsd	%xmm3, %xmm2, %xmm2
	vaddsd	%xmm2, %xmm8, %xmm9
	vpermilpd	$1, %xmm8, %xmm3        # xmm3 = xmm8[1,0]
	vpermilpd	$1, %xmm5, %xmm2        # xmm2 = xmm5[1,0]
	vaddsd	%xmm2, %xmm5, %xmm2
	vaddsd	%xmm2, %xmm3, %xmm2
	vunpcklpd	%xmm2, %xmm9, %xmm5     # xmm5 = xmm9[0],xmm2[0]
	vpermilpd	$1, %xmm1, %xmm2        # xmm2 = xmm1[1,0]
	vaddsd	%xmm2, %xmm1, %xmm1
	vmovupd	144(%rsp), %ymm4                # 32-byte Reload
	vaddsd	%xmm1, %xmm4, %xmm1
	vpermilpd	$1, %xmm4, %xmm2        # xmm2 = xmm4[1,0]
	vpermilpd	$1, %xmm7, %xmm3        # xmm3 = xmm7[1,0]
	vaddsd	%xmm3, %xmm7, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm2
	vunpcklpd	%xmm2, %xmm1, %xmm7     # xmm7 = xmm1[0],xmm2[0]
	vextractf128	$1, %ymm4, %xmm1
	vpermilpd	$1, %xmm0, %xmm2        # xmm2 = xmm0[1,0]
	vaddsd	%xmm2, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vpermilpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	vpermilpd	$1, %xmm6, %xmm2        # xmm2 = xmm6[1,0]
	vaddsd	%xmm2, %xmm6, %xmm2
	vaddsd	%xmm2, %xmm1, %xmm1
	vunpcklpd	%xmm1, %xmm0, %xmm6     # xmm6 = xmm0[0],xmm1[0]
	movq	%rbp, %rsi
	movq	-112(%rsp), %r9                 # 8-byte Reload
	.loc	1 31 5                          # multiply.c:31:5
	cmpq	%r9, %rbp
	movq	-48(%rsp), %r12                 # 8-byte Reload
	movq	-56(%rsp), %r14                 # 8-byte Reload
	movq	-64(%rsp), %r10                 # 8-byte Reload
	movq	-72(%rsp), %r13                 # 8-byte Reload
	movq	%rdi, %rcx
	movq	-80(%rsp), %r8                  # 8-byte Reload
	vmovupd	208(%rsp), %ymm8                # 32-byte Reload
	vmovupd	32(%rsp), %xmm9                 # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	vmovupd	176(%rsp), %ymm11               # 32-byte Reload
	vmovupd	16(%rsp), %xmm12                # 16-byte Reload
                                        # AlignMOV convert to UnAlignMOV 
	.loc	1 33 9                          # multiply.c:33:9
	je	.LBB0_11
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_5:                                #   in Loop: Header=BB0_4 Depth=1
	movq	%rsi, %r12
	movq	%r15, %r14
	xorl	%esi, %esi
	movq	-112(%rsp), %r9                 # 8-byte Reload
	movq	-120(%rsp), %r15                # 8-byte Reload
	movq	-104(%rsp), %rcx                # 8-byte Reload
.LBB0_6:                                #   in Loop: Header=BB0_4 Depth=1
	.loc	1 34 21                         # multiply.c:34:21
	movq	%rbx, %rax
	imulq	-88(%rsp), %rax                 # 8-byte Folded Reload
	.p2align	4, 0x90
.LBB0_7:                                #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rax,%rsi), %rdi
	leaq	(%rdi,%r15), %rbp
	.loc	1 34 29 is_stmt 0               # multiply.c:34:29
	vmovsd	(%r11,%rsi,8), %xmm0            # xmm0 = mem[0],zero
	vmovhpd	(%rdx,%rbp,8), %xmm0, %xmm0     # xmm0 = xmm0[0],mem[0]
	movq	8(%rsp), %rbp                   # 8-byte Reload
	.loc	1 34 21                         # multiply.c:34:21
	addq	%rdi, %rbp
	.loc	1 34 29                         # multiply.c:34:29
	vmovsd	(%rdx,%rbp,8), %xmm1            # xmm1 = mem[0],zero
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%r12,%rdi), %rbp
	.loc	1 34 29                         # multiply.c:34:29
	vmovhpd	(%rdx,%rbp,8), %xmm1, %xmm1     # xmm1 = xmm1[0],mem[0]
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%r14,%rdi), %rbp
	.loc	1 34 29                         # multiply.c:34:29
	vmovsd	(%rdx,%rbp,8), %xmm2            # xmm2 = mem[0],zero
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%r10,%rdi), %rbp
	.loc	1 34 29                         # multiply.c:34:29
	vmovhpd	(%rdx,%rbp,8), %xmm2, %xmm2     # xmm2 = xmm2[0],mem[0]
	.loc	1 34 21                         # multiply.c:34:21
	leaq	(%rdi,%r13), %rbp
	.loc	1 34 29                         # multiply.c:34:29
	vmovsd	(%rdx,%rbp,8), %xmm3            # xmm3 = mem[0],zero
	.loc	1 34 21                         # multiply.c:34:21
	addq	%r8, %rdi
	.loc	1 34 29                         # multiply.c:34:29
	vmovhpd	(%rdx,%rdi,8), %xmm3, %xmm3     # xmm3 = xmm3[0],mem[0]
	vmovddup	(%rcx,%rsi,8), %xmm4            # xmm4 = mem[0,0]
	vmulpd	%xmm0, %xmm4, %xmm0
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm0, %xmm8, %xmm0
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm0, %xmm10, %xmm10
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	%xmm1, %xmm4, %xmm0
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm0, %xmm9, %xmm0
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm5, %xmm0, %xmm5
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	%xmm2, %xmm4, %xmm0
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm0, %xmm11, %xmm0
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm7, %xmm0, %xmm7
	.loc	1 34 29                         # multiply.c:34:29
	vmulpd	%xmm3, %xmm4, %xmm0
	.loc	1 34 36                         # multiply.c:34:36
	vaddpd	%xmm0, %xmm12, %xmm0
	.loc	1 34 18                         # multiply.c:34:18
	vaddpd	%xmm6, %xmm0, %xmm6
	.loc	1 33 23 is_stmt 1               # multiply.c:33:23
	incq	%rsi
	cmpq	%rsi, %r9
	.loc	1 33 9 is_stmt 0                # multiply.c:33:9
	jne	.LBB0_7
	jmp	.LBB0_11
.Ltmp0:
.Lfunc_end0:
	.size	matvec, .Lfunc_end0-matvec
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	0                               # DW_CHILDREN_no
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
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	4                               # DWARF version number
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0x23 DW_TAG_compile_unit
	.long	.Linfo_string0                  # DW_AT_producer
	.long	.Linfo_string1                  # DW_AT_INTEL_comp_flags
	.short	12                              # DW_AT_language
	.long	.Linfo_string2                  # DW_AT_name
	.long	.Lline_table_start0             # DW_AT_stmt_list
	.long	.Linfo_string3                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang based Intel(R) oneAPI DPC++/C++ Compiler 2023.0.0 (2023.0.0.20221201)" # string offset=0
.Linfo_string1:
	.asciz	" --intel -O2 -x avx multiply.c driver.c -S -qopt-report=3 -fargument-noalias -fveclib=SVML -fheinous-gnu-extensions" # string offset=76
.Linfo_string2:
	.asciz	"multiply.c"                    # string offset=192
.Linfo_string3:
	.asciz	"/home/u166450/practice8/compiler-optimization/vectorization/matvector/c/solutions/ivdep" # string offset=203
	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2023.0.0 (2023.0.0.20221201)"
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
