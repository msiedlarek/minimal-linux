; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

; Instcombine should preserve metadata and alignment while
; folding a bitcast into a store.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

%struct.A = type { ptr }

@G = external constant [5 x ptr]

define void @foo(i32 %x, ptr %p) nounwind {
; CHECK-LABEL: define void @foo
; CHECK-SAME: (i32 [[X:%.*]], ptr [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 [[X]], ptr [[P]], align 16, !noalias !0, !llvm.access.group [[ACC_GRP3:![0-9]+]]
; CHECK-NEXT:    ret void
;
entry:
  %x.cast = bitcast i32 %x to float
  store float %x.cast, ptr %p, align 16, !noalias !0, !llvm.access.group !3
  ret void
}

; Check instcombine doesn't try and fold the following bitcast into the store.
; This transformation would not be safe since we would need to use addrspacecast
; and addrspacecast is not guaranteed to be a no-op cast.

define void @bar(ptr addrspace(1) %a, ptr %b) nounwind {
; CHECK-LABEL: define void @bar
; CHECK-SAME: (ptr addrspace(1) [[A:%.*]], ptr [[B:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store ptr addrspace(1) [[A]], ptr [[B]], align 8
; CHECK-NEXT:    ret void
;
entry:
  store ptr addrspace(1) %a, ptr %b
  ret void
}

; Check that we don't combine the bitcast into the store. This would create a
; bitcast of the swifterror which is invalid.

%swift.error = type opaque
define void @swifterror_store(ptr %x, ptr swifterror %err) {
; CHECK-LABEL: define void @swifterror_store
; CHECK-SAME: (ptr [[X:%.*]], ptr swifterror [[ERR:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store ptr [[X]], ptr [[ERR]], align 8
; CHECK-NEXT:    ret void
;
entry:
  store ptr %x, ptr %err
  ret void
}

define void @ppcf128_ones_store(ptr %dest) {
; CHECK-LABEL: define void @ppcf128_ones_store
; CHECK-SAME: (ptr [[DEST:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store ppc_fp128 0xMFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, ptr [[DEST]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %int = or i128 0, 340282366920938463463374607431768211455 ; 128 ones
  %val = bitcast i128 %int to ppc_fp128
  store ppc_fp128 %val, ptr %dest, align 16
  ret void
}

!0 = !{!1}
!1 = !{!1, !2}
!2 = !{!2}
!3 = !{}
