; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=arm64-eabi -mcpu=cyclone | FileCheck %s

%struct.x = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8 }

@src = external dso_local global %struct.x
@dst = external dso_local global %struct.x

@.str1 = private unnamed_addr constant [31 x i8] c"DHRYSTONE PROGRAM, SOME STRING\00", align 1
@.str2 = private unnamed_addr constant [36 x i8] c"DHRYSTONE PROGRAM, SOME STRING BLAH\00", align 1
@.str3 = private unnamed_addr constant [24 x i8] c"DHRYSTONE PROGRAM, SOME\00", align 1
@.str4 = private unnamed_addr constant [18 x i8] c"DHRYSTONE PROGR  \00", align 1
@.str5 = private unnamed_addr constant [7 x i8] c"DHRYST\00", align 1
@.str6 = private unnamed_addr constant [14 x i8] c"/tmp/rmXXXXXX\00", align 1
@spool.splbuf = internal global [512 x i8] zeroinitializer, align 16

define i32 @t0() {
; CHECK-LABEL: t0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, src
; CHECK-NEXT:    add x8, x8, :lo12:src
; CHECK-NEXT:    ldr x9, [x8]
; CHECK-NEXT:    adrp x10, dst
; CHECK-NEXT:    add x10, x10, :lo12:dst
; CHECK-NEXT:    str x9, [x10]
; CHECK-NEXT:    ldur w8, [x8, #7]
; CHECK-NEXT:    stur w8, [x10, #7]
; CHECK-NEXT:    mov w0, #0 // =0x0
; CHECK-NEXT:    ret
entry:
  call void @llvm.memcpy.p0.p0.i32(ptr align 8 @dst, ptr align 8 @src, i32 11, i1 false)
  ret i32 0
}

define void @t1(ptr nocapture %C) nounwind {
; CHECK-LABEL: t1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, .L.str1
; CHECK-NEXT:    add x8, x8, :lo12:.L.str1
; CHECK-NEXT:    ldr q0, [x8]
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ldur q0, [x8, #15]
; CHECK-NEXT:    stur q0, [x0, #15]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %C, ptr @.str1, i64 31, i1 false)
  ret void
}

define void @t2(ptr nocapture %C) nounwind {
; CHECK-LABEL: t2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #16716 // =0x414c
; CHECK-NEXT:    movk w8, #72, lsl #16
; CHECK-NEXT:    str w8, [x0, #32]
; CHECK-NEXT:    adrp x8, .L.str2
; CHECK-NEXT:    add x8, x8, :lo12:.L.str2
; CHECK-NEXT:    ldp q0, q1, [x8]
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %C, ptr @.str2, i64 36, i1 false)
  ret void
}

define void @t3(ptr nocapture %C) nounwind {
; CHECK-LABEL: t3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, .L.str3
; CHECK-NEXT:    add x8, x8, :lo12:.L.str3
; CHECK-NEXT:    ldr q0, [x8]
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ldr x8, [x8, #16]
; CHECK-NEXT:    str x8, [x0, #16]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %C, ptr @.str3, i64 24, i1 false)
  ret void
}

define void @t4(ptr nocapture %C) nounwind {
; CHECK-LABEL: t4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #32 // =0x20
; CHECK-NEXT:    strh w8, [x0, #16]
; CHECK-NEXT:    adrp x8, .L.str4
; CHECK-NEXT:    add x8, x8, :lo12:.L.str4
; CHECK-NEXT:    ldr q0, [x8]
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %C, ptr @.str4, i64 18, i1 false)
  ret void
}

define void @t5(ptr nocapture %C) nounwind {
; CHECK-LABEL: t5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #21337 // =0x5359
; CHECK-NEXT:    movk w8, #84, lsl #16
; CHECK-NEXT:    stur w8, [x0, #3]
; CHECK-NEXT:    mov w8, #18500 // =0x4844
; CHECK-NEXT:    movk w8, #22866, lsl #16
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %C, ptr @.str5, i64 7, i1 false)
  ret void
}

define void @t6() nounwind {
; CHECK-LABEL: t6:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, .L.str6
; CHECK-NEXT:    add x8, x8, :lo12:.L.str6
; CHECK-NEXT:    ldr x9, [x8]
; CHECK-NEXT:    adrp x10, spool.splbuf
; CHECK-NEXT:    add x10, x10, :lo12:spool.splbuf
; CHECK-NEXT:    str x9, [x10]
; CHECK-NEXT:    ldur x8, [x8, #6]
; CHECK-NEXT:    stur x8, [x10, #6]
; CHECK-NEXT:    ret
entry:
  call void @llvm.memcpy.p0.p0.i64(ptr @spool.splbuf, ptr @.str6, i64 14, i1 false)
  ret void
}

%struct.Foo = type { i32, i32, i32, i32 }

define void @t7(ptr nocapture %a, ptr nocapture %b) nounwind {
; CHECK-LABEL: t7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i32(ptr align 4 %a, ptr align 4 %b, i32 16, i1 false)
  ret void
}

declare void @llvm.memcpy.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind
