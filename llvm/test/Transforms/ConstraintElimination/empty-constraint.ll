; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

; Make sure constraints where all variable coefficients are 0 are handled
; properly.

define i1 @test_1_always_false(i32 %A, i32 %B) {
; CHECK-LABEL: @test_1_always_false(
; CHECK-NEXT:    br i1 false, label [[IF_END_I16:%.*]], label [[IF_THEN_I10:%.*]]
; CHECK:       if.then.i10:
; CHECK-NEXT:    ret i1 false
; CHECK:       if.end.i16:
; CHECK-NEXT:    ret i1 false
;
  %c.1 = icmp ugt i32 %A, %A
  br i1 %c.1, label %if.end.i16, label %if.then.i10

if.then.i10:
  ret i1 false

if.end.i16:
  %c.2 = icmp ugt i32 %A, %A
  ret i1 %c.2
}

define i1 @test_2_always_true(i32 %A, i32 %B) {
; CHECK-LABEL: @test_2_always_true(
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_END_I16:%.*]], label [[IF_THEN_I10:%.*]]
; CHECK:       if.then.i10:
; CHECK-NEXT:    ret i1 false
; CHECK:       if.end.i16:
; CHECK-NEXT:    ret i1 true
;
  %c.1 = icmp uge i32 %A, %B
  br i1 %c.1, label %if.end.i16, label %if.then.i10

if.then.i10:
  ret i1 false

if.end.i16:
  %c.2 = icmp uge i32 %A, %A
  ret i1 %c.2
}
