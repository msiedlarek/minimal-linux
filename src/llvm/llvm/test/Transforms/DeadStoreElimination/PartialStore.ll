; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=dse -enable-dse-partial-store-merging=false -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

; Ensure that the dead store is deleted in this case.  It is wholely
; overwritten by the second store.
define void @test1(ptr %V) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    store i32 1234567, ptr [[V:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %V
  store i32 1234567, ptr %V
  ret void
}

; Note that we could do better by merging the two stores into one.
define void @test2(ptr %P) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    store i16 1, ptr [[P]], align 2
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P
  store i16 1, ptr %P
  ret void
}


define i32 @test3(double %__x) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[__U:%.*]] = alloca { [3 x i32] }, align 4
; CHECK-NEXT:    store double [[__X:%.*]], ptr [[__U]], align 8
; CHECK-NEXT:    [[TMP_4:%.*]] = getelementptr { [3 x i32] }, ptr [[__U]], i32 0, i32 0, i32 1
; CHECK-NEXT:    [[TMP_5:%.*]] = load i32, ptr [[TMP_4]], align 4
; CHECK-NEXT:    [[TMP_6:%.*]] = icmp slt i32 [[TMP_5]], 0
; CHECK-NEXT:    [[TMP_7:%.*]] = zext i1 [[TMP_6]] to i32
; CHECK-NEXT:    ret i32 [[TMP_7]]
;
  %__u = alloca { [3 x i32] }
  store double %__x, ptr %__u
  %tmp.4 = getelementptr { [3 x i32] }, ptr %__u, i32 0, i32 0, i32 1
  %tmp.5 = load i32, ptr %tmp.4
  %tmp.6 = icmp slt i32 %tmp.5, 0
  %tmp.7 = zext i1 %tmp.6 to i32
  ret i32 %tmp.7
}

; PR6043
define void @test4(ptr %P) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    store double 0.000000e+00, ptr [[P:%.*]], align 8
; CHECK-NEXT:    ret void
;

  store i8 19, ptr %P  ;; dead
  %A = getelementptr i8, ptr %P, i32 3

  store i8 42, ptr %A  ;; dead

  store double 0.0, ptr %P
  ret void
}

; PR8657
declare void @test5a(ptr)
define void @test5(i32 %i) nounwind ssp {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 20, ptr [[A]], align 4
; CHECK-NEXT:    call void @test5a(ptr [[A]])
; CHECK-NEXT:    ret void
;
  %A = alloca i32
  %C = getelementptr i8, ptr %A, i32 %i
  store i8 10, ptr %C        ;; Dead store to variable index.
  store i32 20, ptr %A

  call void @test5a(ptr %A)
  ret void
}

declare void @test5a_as1(ptr)
define void @test5_addrspacecast(i32 %i) nounwind ssp {
; CHECK-LABEL: @test5_addrspacecast(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 20, ptr [[A]], align 4
; CHECK-NEXT:    call void @test5a(ptr [[A]])
; CHECK-NEXT:    ret void
;
  %A = alloca i32
  %B = addrspacecast ptr %A to ptr addrspace(1)
  %C = getelementptr i8, ptr addrspace(1) %B, i32 %i
  store i8 10, ptr addrspace(1) %C        ;; Dead store to variable index.
  store i32 20, ptr %A

  call void @test5a(ptr %A)
  ret void
}