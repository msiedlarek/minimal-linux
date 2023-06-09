// RUN: %clang_cc1 -triple x86_64-gnu-linux -O3 -disable-llvm-passes -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK64
// RUN: %clang_cc1 -triple x86_64-windows-pc -O3 -disable-llvm-passes -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK64
// RUN: %clang_cc1 -triple i386-gnu-linux -O3 -disable-llvm-passes -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,LIN32
// RUN: %clang_cc1 -triple i386-windows-pc -O3 -disable-llvm-passes -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,WIN32

//GH62207
unsigned _BitInt(1) GlobSize1 = 0;
// CHECK: @GlobSize1 = {{.*}}global i1 false

void GenericTest(_BitInt(3) a, unsigned _BitInt(3) b, _BitInt(4) c) {
  // CHECK: define {{.*}}void @GenericTest
  int which = _Generic(a, _BitInt(3): 1, unsigned _BitInt(3) : 2, _BitInt(4) : 3);
  // CHECK: store i32 1
  int which2 = _Generic(b, _BitInt(3): 1, unsigned _BitInt(3) : 2, _BitInt(4) : 3);
  // CHECK: store i32 2
  int which3 = _Generic(c, _BitInt(3): 1, unsigned _BitInt(3) : 2, _BitInt(4) : 3);
  // CHECK: store i32 3
}

void VLATest(_BitInt(3) A, _BitInt(99) B, _BitInt(123) C) {
  // CHECK: define {{.*}}void @VLATest
  int AR1[A];
  // CHECK: %[[A:.+]] = zext i3 %{{.+}} to i[[INDXSIZE:[0-9]+]]
  // CHECK: %[[VLA1:.+]] = alloca i32, i[[INDXSIZE]] %[[A]]
  int AR2[B];
  // CHECK: %[[B:.+]] = trunc i99 %{{.+}} to i[[INDXSIZE]]
  // CHECK: %[[VLA2:.+]] = alloca i32, i[[INDXSIZE]] %[[B]]
  int AR3[C];
  // CHECK: %[[C:.+]] = trunc i123 %{{.+}} to i[[INDXSIZE]]
  // CHECK: %[[VLA3:.+]] = alloca i32, i[[INDXSIZE]] %[[C]]
}

struct S {
  _BitInt(17) A;
  _BitInt(128) B;
  _BitInt(17) C;
};

void OffsetOfTest(void) {
  // CHECK: define {{.*}}void @OffsetOfTest
  int A = __builtin_offsetof(struct S,A);
  // CHECK: store i32 0, ptr %{{.+}}
  int B = __builtin_offsetof(struct S,B);
  // CHECK64: store i32 8, ptr %{{.+}}
  // LIN32: store i32 4, ptr %{{.+}}
  // WINCHECK32: store i32 8, ptr %{{.+}}
  int C = __builtin_offsetof(struct S,C);
  // CHECK64: store i32 24, ptr %{{.+}}
  // LIN32: store i32 20, ptr %{{.+}}
  // WIN32: store i32 24, ptr %{{.+}}
}

void Size1ExtIntParam(unsigned _BitInt(1) A) {
  // CHECK: define {{.*}}void @Size1ExtIntParam(i1{{.*}}  %[[PARAM:.+]])
  // CHECK: %[[PARAM_ADDR:.+]] = alloca i1
  // CHECK: %[[B:.+]] = alloca [5 x i1]
  // CHECK: store i1 %[[PARAM]], ptr %[[PARAM_ADDR]]
  unsigned _BitInt(1) B[5];

  // CHECK: %[[PARAM_LOAD:.+]] = load i1, ptr %[[PARAM_ADDR]]
  // CHECK: %[[IDX:.+]] = getelementptr inbounds [5 x i1], ptr %[[B]]
  // CHECK: store i1 %[[PARAM_LOAD]], ptr %[[IDX]]
  B[2] = A;
}
