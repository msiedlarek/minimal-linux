// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple riscv32 -emit-llvm %s -o - \
// RUN:   | FileCheck -check-prefix=NOZFH %s
// RUN: %clang_cc1 -triple riscv64 -emit-llvm %s -o - \
// RUN:   | FileCheck -check-prefix=NOZFH %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +zfh -emit-llvm %s -o - \
// RUN:   | FileCheck -check-prefix=ZFH %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +zfh -emit-llvm %s -o - \
// RUN:   | FileCheck -check-prefix=ZFH %s

_Float16 x, y, z;

// With no native half type support (no zfh), f16 will be promoted to f32.
// With zfh, it shouldn't be.

// NOZFH-LABEL: define dso_local void @f16_add
// NOZFH-SAME: () #[[ATTR0:[0-9]+]] {
// NOZFH-NEXT:  entry:
// NOZFH-NEXT:    [[TMP0:%.*]] = load half, ptr @y, align 2
// NOZFH-NEXT:    [[EXT:%.*]] = fpext half [[TMP0]] to float
// NOZFH-NEXT:    [[TMP1:%.*]] = load half, ptr @z, align 2
// NOZFH-NEXT:    [[EXT1:%.*]] = fpext half [[TMP1]] to float
// NOZFH-NEXT:    [[ADD:%.*]] = fadd float [[EXT]], [[EXT1]]
// NOZFH-NEXT:    [[UNPROMOTION:%.*]] = fptrunc float [[ADD]] to half
// NOZFH-NEXT:    store half [[UNPROMOTION]], ptr @x, align 2
// NOZFH-NEXT:    ret void
//
// ZFH-LABEL: define dso_local void @f16_add
// ZFH-SAME: () #[[ATTR0:[0-9]+]] {
// ZFH-NEXT:  entry:
// ZFH-NEXT:    [[TMP0:%.*]] = load half, ptr @y, align 2
// ZFH-NEXT:    [[TMP1:%.*]] = load half, ptr @z, align 2
// ZFH-NEXT:    [[ADD:%.*]] = fadd half [[TMP0]], [[TMP1]]
// ZFH-NEXT:    store half [[ADD]], ptr @x, align 2
// ZFH-NEXT:    ret void
//
void f16_add() {
  x = y + z;
}
