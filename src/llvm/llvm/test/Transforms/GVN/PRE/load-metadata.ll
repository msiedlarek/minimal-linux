; RUN: opt -S -passes=gvn < %s | FileCheck %s

define i32 @test1(ptr %p, i1 %C) {
; CHECK-LABEL: @test1(
block1:
	br i1 %C, label %block2, label %block3

block2:
 br label %block4
; CHECK: block2:
; CHECK-NEXT: load i32, ptr %p, align 4, !range !0, !invariant.group !1

block3:
  store i32 0, ptr %p
  br label %block4

block4:
  %PRE = load i32, ptr %p, !range !0, !invariant.group !1
  ret i32 %PRE
}


!0 = !{i32 40, i32 100}
!1 = !{!"magic ptr"}
