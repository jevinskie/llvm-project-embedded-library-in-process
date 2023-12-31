// RUN: %clang_cc1 %s -emit-llvm -ffp-exception-behavior=maytrap -o - -triple arm64-none-linux-gnu | FileCheck %s

// Test that the constrained intrinsics are picking up the exception
// metadata from the AST instead of the global default from the command line.

#pragma float_control(except, on)

int printf(const char *, ...);

// CHECK-LABEL: @p(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[STR_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[STR:%.*]], ptr [[STR_ADDR]], align 8
// CHECK-NEXT:    store i32 [[X:%.*]], ptr [[X_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[STR_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[X_ADDR]], align 4
// CHECK-NEXT:    [[CALL:%.*]] = call i32 (ptr, ...) @printf(ptr noundef @.str, ptr noundef [[TMP0]], i32 noundef [[TMP1]])  [[ATTR4:#.*]]
// CHECK-NEXT:    ret void
//
void p(char *str, int x) {
  printf("%s: %d\n", str, x);
}

#define P(n,args) p(#n #args, __builtin_##n args)

// CHECK-LABEL: @test_long_double_isinf(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca fp128, align 16
// CHECK-NEXT:    store fp128 [[D:%.*]], ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load fp128, ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.is.fpclass.f128(fp128 [[TMP0]], i32 516)
// CHECK-NEXT:    [[RES:%.*]] = zext i1 [[TMP1]] to i32
// CHECK-NEXT:    call void @p(ptr noundef @.str.[[#STRID:1]], i32 noundef [[RES]]) [[ATTR4]]
// CHECK-NEXT:    ret void
//
void test_long_double_isinf(long double ld) {
  P(isinf, (ld));

  return;
}

// CHECK-LABEL: @test_long_double_isfinite(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca fp128, align 16
// CHECK-NEXT:    store fp128 [[D:%.*]], ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load fp128, ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.is.fpclass.f128(fp128 [[TMP0]], i32 504)
// CHECK-NEXT:    [[RES:%.*]] = zext i1 [[TMP1]] to i32
// CHECK-NEXT:    call void @p(ptr noundef @.str.[[#STRID:STRID+1]], i32 noundef [[RES]]) [[ATTR4]]
// CHECK-NEXT:    ret void
//
void test_long_double_isfinite(long double ld) {
  P(isfinite, (ld));

  return;
}

// CHECK-LABEL: @test_long_double_isnan(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca fp128, align 16
// CHECK-NEXT:    store fp128 [[D:%.*]], ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP0:%.*]] = load fp128, ptr [[LD_ADDR]], align 16
// CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.is.fpclass.f128(fp128 [[TMP0]], i32 3)
// CHECK-NEXT:    [[RES:%.*]] = zext i1 [[TMP1]] to i32
// CHECK-NEXT:    call void @p(ptr noundef @.str.[[#STRID:STRID+1]], i32 noundef [[RES]])
// CHECK-NEXT:    ret void
//
void test_long_double_isnan(long double ld) {
  P(isnan, (ld));

  return;
}
