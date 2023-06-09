; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes='move-auto-init' -verify-memoryssa | FileCheck %s

; Checks that auto-init memory isntruction are mot moved when writing to an sret argument.

target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"

%struct.S = type { i64 }

@pattern = private unnamed_addr constant %struct.S { i64 -1 }, align 4

define void @f(ptr noalias sret(%struct.S) align 4 %0, i32 noundef %1) {
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[TMP3:%.*]] = alloca ptr, align 4
; CHECK-NEXT:    [[TMP4:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP5:%.*]] = alloca [[STRUCT_S:%.*]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast ptr [[TMP0:%.*]] to ptr
; CHECK-NEXT:    store ptr [[TMP6]], ptr [[TMP3]], align 4
; CHECK-NEXT:    store i32 [[TMP1:%.*]], ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast ptr [[TMP0]] to ptr
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 4 [[TMP7]], ptr align 4 @pattern, i32 8, i1 false), !annotation !0
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP8]], 42
; CHECK-NEXT:    br i1 [[TMP9]], label [[TMP10:%.*]], label [[TMP13:%.*]]
; CHECK:       10:
; CHECK-NEXT:    call void @g(ptr sret([[STRUCT_S]]) align 4 [[TMP5]])
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast ptr [[TMP0]] to ptr
; CHECK-NEXT:    [[TMP12:%.*]] = bitcast ptr [[TMP5]] to ptr
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 4 [[TMP11]], ptr align 4 [[TMP12]], i32 8, i1 false)
; CHECK-NEXT:    br label [[TMP13]]
; CHECK:       13:
; CHECK-NEXT:    ret void
;
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.S, align 4
  %6 = bitcast ptr %0 to ptr
  store ptr %6, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = bitcast ptr %0 to ptr
  call void @llvm.memcpy.p0.p0.i32(ptr align 4 %7, ptr align 4 @pattern, i32 8, i1 false), !annotation !0
  %8 = load i32, ptr %4, align 4
  %9 = icmp eq i32 %8, 42
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  call void @g(ptr sret(%struct.S) align 4 %5)
  %11 = bitcast ptr %0 to ptr
  %12 = bitcast ptr %5 to ptr
  call void @llvm.memcpy.p0.p0.i32(ptr align 4 %11, ptr align 4 %12, i32 8, i1 false)
  br label %13

13:                                               ; preds = %10, %2
  ret void
}

declare void @g(ptr sret(%struct.S) align 4, ...)

declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg) #0

!0 = !{!"auto-init"}

