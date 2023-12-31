; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; Check that the default heuristic use the local cse constraints.
; RUN: opt -S -passes=reassociate %s -o - | FileCheck %s -check-prefix=LOCAL_CSE
; RUN: opt -S -passes=reassociate %s -reassociate-use-cse-local=true -o - | FileCheck %s -check-prefix=LOCAL_CSE
; RUN: opt -S -passes=reassociate %s -reassociate-use-cse-local=false -o - | FileCheck %s -check-prefix=CSE

; In the local CSE mode, we check that we don't create loop dependent
; expressions in order to expose more CSE opportunities.
; This can be seen with %inv4 and %inv5 that should stay in the entry block.
;
; For the non-local CSE mode, we form CSE-able expression regardless of where
; they would be materialized. In this case, %inv4 and %inv5 are pushed
; down the loop body in order to make loop_dependent, %inv2 appear as a
; sub-expression.
;
; Related to issue PR61458.
define void @reassoc_defeats_licm(i64 %inv1, i64 %inv2, i64 %inv3) {
; LOCAL_CSE-LABEL: define void @reassoc_defeats_licm
; LOCAL_CSE-SAME: (i64 [[INV1:%.*]], i64 [[INV2:%.*]], i64 [[INV3:%.*]]) {
; LOCAL_CSE-NEXT:  bb:
; LOCAL_CSE-NEXT:    [[INV4:%.*]] = add nuw nsw i64 [[INV2]], [[INV1]]
; LOCAL_CSE-NEXT:    [[INV5:%.*]] = add nuw nsw i64 [[INV3]], [[INV2]]
; LOCAL_CSE-NEXT:    br label [[BB214:%.*]]
; LOCAL_CSE:       bb214:
; LOCAL_CSE-NEXT:    [[IV1:%.*]] = phi i64 [ [[IV2:%.*]], [[BB214]] ], [ 0, [[BB:%.*]] ]
; LOCAL_CSE-NEXT:    [[IV2]] = phi i64 [ [[IV2_PLUS_1:%.*]], [[BB214]] ], [ 1, [[BB]] ]
; LOCAL_CSE-NEXT:    [[LOOP_DEPENDENT:%.*]] = shl nuw nsw i64 [[IV1]], 13
; LOCAL_CSE-NEXT:    [[LOOP_DEPENDENT2:%.*]] = add nsw i64 [[INV4]], [[LOOP_DEPENDENT]]
; LOCAL_CSE-NEXT:    call void @keep_alive(i64 [[LOOP_DEPENDENT2]])
; LOCAL_CSE-NEXT:    [[LOOP_DEPENDENT3:%.*]] = add i64 [[INV5]], [[LOOP_DEPENDENT]]
; LOCAL_CSE-NEXT:    call void @keep_alive(i64 [[LOOP_DEPENDENT3]])
; LOCAL_CSE-NEXT:    [[IV2_PLUS_1]] = add i64 [[IV2]], 1
; LOCAL_CSE-NEXT:    br label [[BB214]]
;
; CSE-LABEL: define void @reassoc_defeats_licm
; CSE-SAME: (i64 [[INV1:%.*]], i64 [[INV2:%.*]], i64 [[INV3:%.*]]) {
; CSE-NEXT:  bb:
; CSE-NEXT:    br label [[BB214:%.*]]
; CSE:       bb214:
; CSE-NEXT:    [[IV1:%.*]] = phi i64 [ [[IV2:%.*]], [[BB214]] ], [ 0, [[BB:%.*]] ]
; CSE-NEXT:    [[IV2]] = phi i64 [ [[IV2_PLUS_1:%.*]], [[BB214]] ], [ 1, [[BB]] ]
; CSE-NEXT:    [[LOOP_DEPENDENT:%.*]] = shl nuw nsw i64 [[IV1]], 13
; CSE-NEXT:    [[INV4:%.*]] = add i64 [[LOOP_DEPENDENT]], [[INV2]]
; CSE-NEXT:    [[LOOP_DEPENDENT2:%.*]] = add i64 [[INV4]], [[INV1]]
; CSE-NEXT:    call void @keep_alive(i64 [[LOOP_DEPENDENT2]])
; CSE-NEXT:    [[INV5:%.*]] = add i64 [[LOOP_DEPENDENT]], [[INV2]]
; CSE-NEXT:    [[LOOP_DEPENDENT3:%.*]] = add i64 [[INV5]], [[INV3]]
; CSE-NEXT:    call void @keep_alive(i64 [[LOOP_DEPENDENT3]])
; CSE-NEXT:    [[IV2_PLUS_1]] = add i64 [[IV2]], 1
; CSE-NEXT:    br label [[BB214]]
;
bb:
  %inv4 = add nuw nsw i64 %inv1, %inv2
  %inv5 = add nuw nsw i64 %inv2, %inv3
  br label %bb214

bb214:                                            ; preds = %bb214, %bb
  %iv1 = phi i64 [ %iv2, %bb214 ], [ 0, %bb ]
  %iv2 = phi i64 [ %iv2_plus_1, %bb214 ], [ 1, %bb ]
  %loop_dependent = shl nuw nsw i64 %iv1, 13
  %loop_dependent2 = add nsw i64 %inv4, %loop_dependent
  call void @keep_alive(i64 %loop_dependent2)
  %loop_dependent3 = add i64 %inv5, %loop_dependent
  call void @keep_alive(i64 %loop_dependent3)
  %iv2_plus_1 = add i64 %iv2, 1
  br label %bb214
}

declare void @keep_alive(i64)
