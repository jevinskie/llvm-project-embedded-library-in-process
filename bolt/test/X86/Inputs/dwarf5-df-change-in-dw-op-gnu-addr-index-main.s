# clang++ -O2 -g -gdwarf-5 -gsplit-dwarf main.cpp
# void use(int * x, int * y) {
#  static int Foo = *y + *x;
#  *x += 4;
#  *y -= Foo;
# }
#
# int x = 0;
# int y = 1;
# int  main(int argc, char *argv[]) {
#    x = argc;
#    y = argc + 3;
#    use(&x, &y);
#    return 0;
# }
	.text
	.file	"main.cpp"
	.file	0 "." "main.cpp" md5 0x4f704c611bdcbf8d7a62eb17d439188e
	.globl	_Z3usePiS_                      # -- Begin function _Z3usePiS_
	.p2align	4, 0x90
	.type	_Z3usePiS_,@function
_Z3usePiS_:                             # @_Z3usePiS_
.Lfunc_begin0:
	.loc	0 1 0                           # main.cpp:1:0
	.cfi_startproc
# %bb.0:                                # %entry
	#DEBUG_VALUE: use:x <- $rdi
	#DEBUG_VALUE: use:y <- $rsi
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rsi, %rbx
	movq	%rdi, %r14
.Ltmp0:
	.loc	0 2 2 prologue_end              # main.cpp:2:2
	movzbl	_ZGVZ3usePiS_E3Foo(%rip), %eax
	testb	%al, %al
	je	.LBB0_1
.Ltmp1:
.LBB0_3:                                # %init.end
	#DEBUG_VALUE: use:x <- $r14
	#DEBUG_VALUE: use:y <- $rbx
	.loc	0 3 5                           # main.cpp:3:5
	addl	$4, (%r14)
	.loc	0 4 8                           # main.cpp:4:8
	movl	_ZZ3usePiS_E3Foo(%rip), %eax
	.loc	0 4 5 is_stmt 0                 # main.cpp:4:5
	subl	%eax, (%rbx)
	.loc	0 5 1 epilogue_begin is_stmt 1  # main.cpp:5:1
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
.Ltmp2:
	#DEBUG_VALUE: use:y <- [DW_OP_LLVM_entry_value 1] $rsi
	.cfi_def_cfa_offset 16
	popq	%r14
.Ltmp3:
	#DEBUG_VALUE: use:x <- [DW_OP_LLVM_entry_value 1] $rdi
	.cfi_def_cfa_offset 8
	retq
.Ltmp4:
.LBB0_1:                                # %init.check
	.cfi_def_cfa_offset 32
	#DEBUG_VALUE: use:x <- $r14
	#DEBUG_VALUE: use:y <- $rbx
	.loc	0 2 2                           # main.cpp:2:2
	leaq	_ZGVZ3usePiS_E3Foo(%rip), %rdi
	callq	__cxa_guard_acquire@PLT
.Ltmp5:
	testl	%eax, %eax
	je	.LBB0_3
.Ltmp6:
# %bb.2:                                # %init
	#DEBUG_VALUE: use:x <- $r14
	#DEBUG_VALUE: use:y <- $rbx
	.loc	0 2 24 is_stmt 0                # main.cpp:2:24
	movl	(%r14), %eax
	.loc	0 2 22                          # main.cpp:2:22
	addl	(%rbx), %eax
	.loc	0 2 2                           # main.cpp:2:2
	movl	%eax, _ZZ3usePiS_E3Foo(%rip)
	leaq	_ZGVZ3usePiS_E3Foo(%rip), %rdi
	callq	__cxa_guard_release@PLT
.Ltmp7:
	.loc	0 0 2                           # main.cpp:0:2
	jmp	.LBB0_3
.Ltmp8:
.Lfunc_end0:
	.size	_Z3usePiS_, .Lfunc_end0-_Z3usePiS_
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
.Lfunc_begin1:
	.cfi_startproc
# %bb.0:                                # %entry
	#DEBUG_VALUE: main:argc <- $edi
	#DEBUG_VALUE: main:argv <- $rsi
	.loc	0 10 6 prologue_end is_stmt 1   # main.cpp:10:6
	movl	%edi, x(%rip)
	.loc	0 11 13                         # main.cpp:11:13
	addl	$3, %edi
.Ltmp9:
	#DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $edi
	.loc	0 11 6 is_stmt 0                # main.cpp:11:6
	movl	%edi, y(%rip)
.Ltmp10:
	#DEBUG_VALUE: use:y <- undef
	#DEBUG_VALUE: use:x <- undef
	.loc	0 2 2 is_stmt 1                 # main.cpp:2:2
	movzbl	_ZGVZ3usePiS_E3Foo(%rip), %eax
	testb	%al, %al
	je	.LBB1_1
.Ltmp11:
.LBB1_4:                                # %_Z3usePiS_.exit
	#DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $edi
	#DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $rsi
	.loc	0 3 5                           # main.cpp:3:5
	addl	$4, x(%rip)
	.loc	0 4 8                           # main.cpp:4:8
	movl	_ZZ3usePiS_E3Foo(%rip), %eax
	.loc	0 4 5 is_stmt 0                 # main.cpp:4:5
	subl	%eax, y(%rip)
.Ltmp12:
	.loc	0 13 4 is_stmt 1                # main.cpp:13:4
	xorl	%eax, %eax
	retq
.Ltmp13:
.LBB1_1:                                # %init.check.i
	#DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $edi
	#DEBUG_VALUE: main:argv <- $rsi
	pushq	%rax
	.cfi_def_cfa_offset 16
.Ltmp14:
	.loc	0 2 2                           # main.cpp:2:2
	leaq	_ZGVZ3usePiS_E3Foo(%rip), %rdi
	callq	__cxa_guard_acquire@PLT
.Ltmp15:
	#DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $rsi
	testl	%eax, %eax
	je	.LBB1_3
.Ltmp16:
# %bb.2:                                # %init.i
	#DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $edi
	#DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $rsi
	.loc	0 2 24 is_stmt 0                # main.cpp:2:24
	movl	x(%rip), %eax
	.loc	0 2 22                          # main.cpp:2:22
	addl	y(%rip), %eax
	.loc	0 2 2                           # main.cpp:2:2
	movl	%eax, _ZZ3usePiS_E3Foo(%rip)
	leaq	_ZGVZ3usePiS_E3Foo(%rip), %rdi
	callq	__cxa_guard_release@PLT
.Ltmp17:
.LBB1_3:
	#DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $edi
	#DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $rsi
	.loc	0 0 2                           # main.cpp:0:2
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	.LBB1_4
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	_ZZ3usePiS_E3Foo,@object        # @_ZZ3usePiS_E3Foo
	.local	_ZZ3usePiS_E3Foo
	.comm	_ZZ3usePiS_E3Foo,4,4
	.type	_ZGVZ3usePiS_E3Foo,@object      # @_ZGVZ3usePiS_E3Foo
	.local	_ZGVZ3usePiS_E3Foo
	.comm	_ZGVZ3usePiS_E3Foo,8,8
	.type	x,@object                       # @x
	.bss
	.globl	x
	.p2align	2, 0x0
x:
	.long	0                               # 0x0
	.size	x, 4

	.type	y,@object                       # @y
	.data
	.globl	y
	.p2align	2, 0x0
y:
	.long	1                               # 0x1
	.size	y, 4

	.section	.debug_loclists.dwo,"e",@progbits
	.long	.Ldebug_list_header_end0-.Ldebug_list_header_start0 # Length
.Ldebug_list_header_start0:
	.short	5                               # Version
	.byte	8                               # Address size
	.byte	0                               # Segment selector size
	.long	4                               # Offset entry count
.Lloclists_table_base0:
	.long	.Ldebug_loc0-.Lloclists_table_base0
	.long	.Ldebug_loc1-.Lloclists_table_base0
	.long	.Ldebug_loc2-.Lloclists_table_base0
	.long	.Ldebug_loc3-.Lloclists_table_base0
.Ldebug_loc0:
	.byte	1                               # DW_LLE_base_addressx
	.byte	3                               #   base address index
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
	.uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
	.byte	1                               # Loc expr size
	.byte	85                              # DW_OP_reg5
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp1-.Lfunc_begin0           #   starting offset
	.uleb128 .Ltmp3-.Lfunc_begin0           #   ending offset
	.byte	1                               # Loc expr size
	.byte	94                              # DW_OP_reg14
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp3-.Lfunc_begin0           #   starting offset
	.uleb128 .Ltmp4-.Lfunc_begin0           #   ending offset
	.byte	4                               # Loc expr size
	.byte	163                             # DW_OP_entry_value
	.byte	1                               # 1
	.byte	85                              # DW_OP_reg5
	.byte	159                             # DW_OP_stack_value
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp4-.Lfunc_begin0           #   starting offset
	.uleb128 .Lfunc_end0-.Lfunc_begin0      #   ending offset
	.byte	1                               # Loc expr size
	.byte	94                              # DW_OP_reg14
	.byte	0                               # DW_LLE_end_of_list
.Ldebug_loc1:
	.byte	1                               # DW_LLE_base_addressx
	.byte	3                               #   base address index
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
	.uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
	.byte	1                               # Loc expr size
	.byte	84                              # DW_OP_reg4
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp1-.Lfunc_begin0           #   starting offset
	.uleb128 .Ltmp2-.Lfunc_begin0           #   ending offset
	.byte	1                               # Loc expr size
	.byte	83                              # DW_OP_reg3
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp2-.Lfunc_begin0           #   starting offset
	.uleb128 .Ltmp4-.Lfunc_begin0           #   ending offset
	.byte	4                               # Loc expr size
	.byte	163                             # DW_OP_entry_value
	.byte	1                               # 1
	.byte	84                              # DW_OP_reg4
	.byte	159                             # DW_OP_stack_value
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp4-.Lfunc_begin0           #   starting offset
	.uleb128 .Lfunc_end0-.Lfunc_begin0      #   ending offset
	.byte	1                               # Loc expr size
	.byte	83                              # DW_OP_reg3
	.byte	0                               # DW_LLE_end_of_list
.Ldebug_loc2:
	.byte	1                               # DW_LLE_base_addressx
	.byte	3                               #   base address index
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Lfunc_begin1-.Lfunc_begin0    #   starting offset
	.uleb128 .Ltmp9-.Lfunc_begin0           #   ending offset
	.byte	1                               # Loc expr size
	.byte	85                              # super-register DW_OP_reg5
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp9-.Lfunc_begin0           #   starting offset
	.uleb128 .Lfunc_end1-.Lfunc_begin0      #   ending offset
	.byte	4                               # Loc expr size
	.byte	163                             # DW_OP_entry_value
	.byte	1                               # 1
	.byte	85                              # super-register DW_OP_reg5
	.byte	159                             # DW_OP_stack_value
	.byte	0                               # DW_LLE_end_of_list
.Ldebug_loc3:
	.byte	1                               # DW_LLE_base_addressx
	.byte	3                               #   base address index
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Lfunc_begin1-.Lfunc_begin0    #   starting offset
	.uleb128 .Ltmp11-.Lfunc_begin0          #   ending offset
	.byte	1                               # Loc expr size
	.byte	84                              # DW_OP_reg4
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp11-.Lfunc_begin0          #   starting offset
	.uleb128 .Ltmp13-.Lfunc_begin0          #   ending offset
	.byte	4                               # Loc expr size
	.byte	163                             # DW_OP_entry_value
	.byte	1                               # 1
	.byte	84                              # DW_OP_reg4
	.byte	159                             # DW_OP_stack_value
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp13-.Lfunc_begin0          #   starting offset
	.uleb128 .Ltmp15-.Lfunc_begin0          #   ending offset
	.byte	1                               # Loc expr size
	.byte	84                              # DW_OP_reg4
	.byte	4                               # DW_LLE_offset_pair
	.uleb128 .Ltmp15-.Lfunc_begin0          #   starting offset
	.uleb128 .Lfunc_end1-.Lfunc_begin0      #   ending offset
	.byte	4                               # Loc expr size
	.byte	163                             # DW_OP_entry_value
	.byte	1                               # 1
	.byte	84                              # DW_OP_reg4
	.byte	159                             # DW_OP_stack_value
	.byte	0                               # DW_LLE_end_of_list
.Ldebug_list_header_end0:
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	74                              # DW_TAG_skeleton_unit
	.byte	0                               # DW_CHILDREN_no
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	114                             # DW_AT_str_offsets_base
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	37                              # DW_FORM_strx1
	.ascii	"\264B"                         # DW_AT_GNU_pubnames
	.byte	25                              # DW_FORM_flag_present
	.byte	118                             # DW_AT_dwo_name
	.byte	37                              # DW_FORM_strx1
	.byte	17                              # DW_AT_low_pc
	.byte	27                              # DW_FORM_addrx
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	115                             # DW_AT_addr_base
	.byte	23                              # DW_FORM_sec_offset
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.short	5                               # DWARF version number
	.byte	4                               # DWARF Unit Type
	.byte	8                               # Address Size (in bytes)
	.long	.debug_abbrev                   # Offset Into Abbrev. Section
	.quad	-3440409667494789237
	.byte	1                               # Abbrev [1] 0x14:0x14 DW_TAG_skeleton_unit
	.long	.Lline_table_start0             # DW_AT_stmt_list
	.long	.Lstr_offsets_base0             # DW_AT_str_offsets_base
	.byte	0                               # DW_AT_comp_dir
                                        # DW_AT_GNU_pubnames
	.byte	1                               # DW_AT_dwo_name
	.byte	3                               # DW_AT_low_pc
	.long	.Lfunc_end1-.Lfunc_begin0       # DW_AT_high_pc
	.long	.Laddr_table_base0              # DW_AT_addr_base
.Ldebug_info_end0:
	.section	.debug_str_offsets,"",@progbits
	.long	12                              # Length of String Offsets Set
	.short	5
	.short	0
.Lstr_offsets_base0:
	.section	.debug_str,"MS",@progbits,1
.Lskel_string0:
	.asciz	"." # string offset=0
.Lskel_string1:
	.asciz	"main.dwo"                      # string offset=38
	.section	.debug_str_offsets,"",@progbits
	.long	.Lskel_string0
	.long	.Lskel_string1
	.section	.debug_str_offsets.dwo,"e",@progbits
	.long	56                              # Length of String Offsets Set
	.short	5
	.short	0
	.section	.debug_str.dwo,"eMS",@progbits,1
.Linfo_string0:
	.asciz	"Foo"                           # string offset=0
.Linfo_string1:
	.asciz	"int"                           # string offset=4
.Linfo_string2:
	.asciz	"x"                             # string offset=8
.Linfo_string3:
	.asciz	"y"                             # string offset=10
.Linfo_string4:
	.asciz	"_Z3usePiS_"                    # string offset=12
.Linfo_string5:
	.asciz	"use"                           # string offset=23
.Linfo_string6:
	.asciz	"main"                          # string offset=27
.Linfo_string7:
	.asciz	"argc"                          # string offset=32
.Linfo_string8:
	.asciz	"argv"                          # string offset=37
.Linfo_string9:
	.asciz	"char"                          # string offset=42
.Linfo_string10:
	.asciz	"clang version 18.0.0 (git@github.com:llvm/llvm-project.git 3a8db0f4bfb57348f49d9603119fa157114bbf8e)" # string offset=47
.Linfo_string11:
	.asciz	"main.cpp"                      # string offset=148
.Linfo_string12:
	.asciz	"main.dwo"                      # string offset=157
	.section	.debug_str_offsets.dwo,"e",@progbits
	.long	0
	.long	4
	.long	8
	.long	10
	.long	12
	.long	23
	.long	27
	.long	32
	.long	37
	.long	42
	.long	47
	.long	148
	.long	157
	.section	.debug_info.dwo,"e",@progbits
	.long	.Ldebug_info_dwo_end0-.Ldebug_info_dwo_start0 # Length of Unit
.Ldebug_info_dwo_start0:
	.short	5                               # DWARF version number
	.byte	5                               # DWARF Unit Type
	.byte	8                               # Address Size (in bytes)
	.long	0                               # Offset Into Abbrev. Section
	.quad	-3440409667494789237
	.byte	1                               # Abbrev [1] 0x14:0x95 DW_TAG_compile_unit
	.byte	10                              # DW_AT_producer
	.short	33                              # DW_AT_language
	.byte	11                              # DW_AT_name
	.byte	12                              # DW_AT_dwo_name
	.byte	2                               # Abbrev [2] 0x1a:0x24 DW_TAG_subprogram
	.byte	3                               # DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	87
                                        # DW_AT_call_all_calls
	.long	88                              # DW_AT_abstract_origin
	.byte	3                               # Abbrev [3] 0x26:0xb DW_TAG_variable
	.byte	0                               # DW_AT_name
	.long	62                              # DW_AT_type
	.byte	0                               # DW_AT_decl_file
	.byte	2                               # DW_AT_decl_line
	.byte	2                               # DW_AT_location
	.byte	161
	.byte	0
	.byte	4                               # Abbrev [4] 0x31:0x6 DW_TAG_formal_parameter
	.byte	0                               # DW_AT_location
	.long	93                              # DW_AT_abstract_origin
	.byte	4                               # Abbrev [4] 0x37:0x6 DW_TAG_formal_parameter
	.byte	1                               # DW_AT_location
	.long	101                             # DW_AT_abstract_origin
	.byte	0                               # End Of Children Mark
	.byte	5                               # Abbrev [5] 0x3e:0x4 DW_TAG_base_type
	.byte	1                               # DW_AT_name
	.byte	5                               # DW_AT_encoding
	.byte	4                               # DW_AT_byte_size
	.byte	6                               # Abbrev [6] 0x42:0xb DW_TAG_variable
	.byte	2                               # DW_AT_name
	.long	62                              # DW_AT_type
                                        # DW_AT_external
	.byte	0                               # DW_AT_decl_file
	.byte	7                               # DW_AT_decl_line
	.byte	2                               # DW_AT_location
	.byte	161
	.byte	1
	.byte	6                               # Abbrev [6] 0x4d:0xb DW_TAG_variable
	.byte	3                               # DW_AT_name
	.long	62                              # DW_AT_type
                                        # DW_AT_external
	.byte	0                               # DW_AT_decl_file
	.byte	8                               # DW_AT_decl_line
	.byte	2                               # DW_AT_location
	.byte	161
	.byte	2
	.byte	7                               # Abbrev [7] 0x58:0x16 DW_TAG_subprogram
	.byte	4                               # DW_AT_linkage_name
	.byte	5                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	1                               # DW_AT_decl_line
                                        # DW_AT_external
                                        # DW_AT_inline
	.byte	8                               # Abbrev [8] 0x5d:0x8 DW_TAG_formal_parameter
	.byte	2                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	1                               # DW_AT_decl_line
	.long	110                             # DW_AT_type
	.byte	8                               # Abbrev [8] 0x65:0x8 DW_TAG_formal_parameter
	.byte	3                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	1                               # DW_AT_decl_line
	.long	110                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	9                               # Abbrev [9] 0x6e:0x5 DW_TAG_pointer_type
	.long	62                              # DW_AT_type
	.byte	10                              # Abbrev [10] 0x73:0x27 DW_TAG_subprogram
	.byte	0                               # DW_AT_ranges
	.byte	1                               # DW_AT_frame_base
	.byte	87
                                        # DW_AT_call_all_calls
	.byte	6                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	9                               # DW_AT_decl_line
	.long	62                              # DW_AT_type
                                        # DW_AT_external
	.byte	11                              # Abbrev [11] 0x7e:0x9 DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	7                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	9                               # DW_AT_decl_line
	.long	62                              # DW_AT_type
	.byte	11                              # Abbrev [11] 0x87:0x9 DW_TAG_formal_parameter
	.byte	3                               # DW_AT_location
	.byte	8                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	9                               # DW_AT_decl_line
	.long	154                             # DW_AT_type
	.byte	12                              # Abbrev [12] 0x90:0x9 DW_TAG_inlined_subroutine
	.long	88                              # DW_AT_abstract_origin
	.byte	1                               # DW_AT_ranges
	.byte	0                               # DW_AT_call_file
	.byte	12                              # DW_AT_call_line
	.byte	4                               # DW_AT_call_column
	.byte	0                               # End Of Children Mark
	.byte	9                               # Abbrev [9] 0x9a:0x5 DW_TAG_pointer_type
	.long	159                             # DW_AT_type
	.byte	9                               # Abbrev [9] 0x9f:0x5 DW_TAG_pointer_type
	.long	164                             # DW_AT_type
	.byte	5                               # Abbrev [5] 0xa4:0x4 DW_TAG_base_type
	.byte	9                               # DW_AT_name
	.byte	6                               # DW_AT_encoding
	.byte	1                               # DW_AT_byte_size
	.byte	0                               # End Of Children Mark
.Ldebug_info_dwo_end0:
	.section	.debug_abbrev.dwo,"e",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	37                              # DW_FORM_strx1
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	118                             # DW_AT_dwo_name
	.byte	37                              # DW_FORM_strx1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	27                              # DW_FORM_addrx
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	122                             # DW_AT_call_all_calls
	.byte	25                              # DW_FORM_flag_present
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	52                              # DW_TAG_variable
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	2                               # DW_AT_location
	.byte	24                              # DW_FORM_exprloc
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	5                               # DW_TAG_formal_parameter
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	34                              # DW_FORM_loclistx
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	5                               # Abbreviation Code
	.byte	36                              # DW_TAG_base_type
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	62                              # DW_AT_encoding
	.byte	11                              # DW_FORM_data1
	.byte	11                              # DW_AT_byte_size
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	6                               # Abbreviation Code
	.byte	52                              # DW_TAG_variable
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	2                               # DW_AT_location
	.byte	24                              # DW_FORM_exprloc
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	7                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	110                             # DW_AT_linkage_name
	.byte	37                              # DW_FORM_strx1
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	32                              # DW_AT_inline
	.byte	33                              # DW_FORM_implicit_const
	.byte	1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	8                               # Abbreviation Code
	.byte	5                               # DW_TAG_formal_parameter
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	9                               # Abbreviation Code
	.byte	15                              # DW_TAG_pointer_type
	.byte	0                               # DW_CHILDREN_no
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	10                              # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	85                              # DW_AT_ranges
	.byte	35                              # DW_FORM_rnglistx
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	122                             # DW_AT_call_all_calls
	.byte	25                              # DW_FORM_flag_present
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	11                              # Abbreviation Code
	.byte	5                               # DW_TAG_formal_parameter
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	34                              # DW_FORM_loclistx
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	12                              # Abbreviation Code
	.byte	29                              # DW_TAG_inlined_subroutine
	.byte	0                               # DW_CHILDREN_no
	.byte	49                              # DW_AT_abstract_origin
	.byte	19                              # DW_FORM_ref4
	.byte	85                              # DW_AT_ranges
	.byte	35                              # DW_FORM_rnglistx
	.byte	88                              # DW_AT_call_file
	.byte	11                              # DW_FORM_data1
	.byte	89                              # DW_AT_call_line
	.byte	11                              # DW_FORM_data1
	.byte	87                              # DW_AT_call_column
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_rnglists.dwo,"e",@progbits
	.long	.Ldebug_list_header_end1-.Ldebug_list_header_start1 # Length
.Ldebug_list_header_start1:
	.short	5                               # Version
	.byte	8                               # Address size
	.byte	0                               # Segment selector size
	.long	2                               # Offset entry count
.Lrnglists_dwo_table_base0:
	.long	.Ldebug_ranges0-.Lrnglists_dwo_table_base0
	.long	.Ldebug_ranges1-.Lrnglists_dwo_table_base0
.Ldebug_ranges0:
	.byte	4                               # DW_RLE_offset_pair
	.uleb128 .Lfunc_begin1-.Lfunc_begin0    #   starting offset
	.uleb128 .Lfunc_end1-.Lfunc_begin0      #   ending offset
	.byte	0                               # DW_RLE_end_of_list
.Ldebug_ranges1:
	.byte	4                               # DW_RLE_offset_pair
	.uleb128 .Ltmp10-.Lfunc_begin0          #   starting offset
	.uleb128 .Ltmp12-.Lfunc_begin0          #   ending offset
	.byte	4                               # DW_RLE_offset_pair
	.uleb128 .Ltmp14-.Lfunc_begin0          #   starting offset
	.uleb128 .Ltmp17-.Lfunc_begin0          #   ending offset
	.byte	0                               # DW_RLE_end_of_list
.Ldebug_list_header_end1:
	.section	.debug_addr,"",@progbits
	.long	.Ldebug_addr_end0-.Ldebug_addr_start0 # Length of contribution
.Ldebug_addr_start0:
	.short	5                               # DWARF version number
	.byte	8                               # Address size
	.byte	0                               # Segment selector size
.Laddr_table_base0:
	.quad	_ZZ3usePiS_E3Foo
	.quad	x
	.quad	y
	.quad	.Lfunc_begin0
.Ldebug_addr_end0:
	.section	.debug_gnu_pubnames,"",@progbits
	.long	.LpubNames_end0-.LpubNames_start0 # Length of Public Names Info
.LpubNames_start0:
	.short	2                               # DWARF Version
	.long	.Lcu_begin0                     # Offset of Compilation Unit Info
	.long	40                              # Compilation Unit Length
	.long	38                              # DIE offset
	.byte	160                             # Attributes: VARIABLE, STATIC
	.asciz	"use::Foo"                      # External Name
	.long	66                              # DIE offset
	.byte	32                              # Attributes: VARIABLE, EXTERNAL
	.asciz	"x"                             # External Name
	.long	77                              # DIE offset
	.byte	32                              # Attributes: VARIABLE, EXTERNAL
	.asciz	"y"                             # External Name
	.long	88                              # DIE offset
	.byte	48                              # Attributes: FUNCTION, EXTERNAL
	.asciz	"use"                           # External Name
	.long	115                             # DIE offset
	.byte	48                              # Attributes: FUNCTION, EXTERNAL
	.asciz	"main"                          # External Name
	.long	0                               # End Mark
.LpubNames_end0:
	.section	.debug_gnu_pubtypes,"",@progbits
	.long	.LpubTypes_end0-.LpubTypes_start0 # Length of Public Types Info
.LpubTypes_start0:
	.short	2                               # DWARF Version
	.long	.Lcu_begin0                     # Offset of Compilation Unit Info
	.long	40                              # Compilation Unit Length
	.long	62                              # DIE offset
	.byte	144                             # Attributes: TYPE, STATIC
	.asciz	"int"                           # External Name
	.long	164                             # DIE offset
	.byte	144                             # Attributes: TYPE, STATIC
	.asciz	"char"                          # External Name
	.long	0                               # End Mark
.LpubTypes_end0:
	.ident	"clang version 18.0.0 (git@github.com:llvm/llvm-project.git 3a8db0f4bfb57348f49d9603119fa157114bbf8e)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZGVZ3usePiS_E3Foo
	.section	.debug_line,"",@progbits
.Lline_table_start0:
