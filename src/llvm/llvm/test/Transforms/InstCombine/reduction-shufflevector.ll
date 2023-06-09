; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i32 @reduce_add(<4 x i32> %x) {
; CHECK-LABEL: @reduce_add(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %res = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_or(<4 x i32> %x) {
; CHECK-LABEL: @reduce_or(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> poison, <4 x i32> %x, <4 x i32> <i32 7, i32 6, i32 5, i32 4>
  %res = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_and(<4 x i32> %x) {
; CHECK-LABEL: @reduce_and(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %res = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_xor(<4 x i32> %x) {
; CHECK-LABEL: @reduce_xor(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> poison, <4 x i32> %x, <4 x i32> <i32 5, i32 6, i32 7, i32 4>
  %res = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_umax(<4 x i32> %x) {
; CHECK-LABEL: @reduce_umax(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 2, i32 1, i32 3, i32 0>
  %res = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_umin(<4 x i32> %x) {
; CHECK-LABEL: @reduce_umin(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %res = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_smax(<4 x i32> %x) {
; CHECK-LABEL: @reduce_smax(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 2, i32 0, i32 3, i32 1>
  %res = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_smin(<4 x i32> %x) {
; CHECK-LABEL: @reduce_smin(
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> [[X:%.*]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define float @reduce_fmax(<4 x float> %x) {
; CHECK-LABEL: @reduce_fmax(
; CHECK-NEXT:    [[RES:%.*]] = call nnan nsz float @llvm.vector.reduce.fmax.v4f32(<4 x float> [[X:%.*]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> <i32 2, i32 0, i32 3, i32 1>
  %res = call nsz nnan float @llvm.vector.reduce.fmax.v4f32(<4 x float> %shuf)
  ret float %res
}

define float @reduce_fmin(<4 x float> %x) {
; CHECK-LABEL: @reduce_fmin(
; CHECK-NEXT:    [[RES:%.*]] = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> [[X:%.*]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> %shuf)
  ret float %res
}

define float @reduce_fadd(float %a, <4 x float> %x) {
; CHECK-LABEL: @reduce_fadd(
; CHECK-NEXT:    [[RES:%.*]] = call reassoc float @llvm.vector.reduce.fadd.v4f32(float [[A:%.*]], <4 x float> [[X:%.*]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> %x, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call reassoc float @llvm.vector.reduce.fadd.v4f32(float %a, <4 x float> %shuf)
  ret float %res
}

define float @reduce_fmul(float %a, <4 x float> %x) {
; CHECK-LABEL: @reduce_fmul(
; CHECK-NEXT:    [[RES:%.*]] = call reassoc float @llvm.vector.reduce.fmul.v4f32(float [[A:%.*]], <4 x float> [[X:%.*]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> zeroinitializer, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call reassoc float @llvm.vector.reduce.fmul.v4f32(float %a, <4 x float> %shuf)
  ret float %res
}

; Failed cases
; TODO: simplify the reductions for shuffles resulting in undef/poison elements.

define i32 @reduce_add_failed(<4 x i32> %x) {
; CHECK-LABEL: @reduce_add_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 0>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 0, i32 1, i32 2, i32 4>
  %res = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_or_failed(<4 x i32> %x) {
; CHECK-LABEL: @reduce_or_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> <i32 0, i32 poison, i32 poison, i32 poison>, <4 x i32> <i32 3, i32 2, i32 1, i32 4>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> zeroinitializer, <4 x i32> <i32 3, i32 2, i32 1, i32 4>
  %res = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_and_failed(<4 x i32> %x) {
; CHECK-LABEL: @reduce_and_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 0>
  %res = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_xor_failed(<4 x i32> %x) {
; CHECK-LABEL: @reduce_xor_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 poison>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <4 x i32> %x, <4 x i32> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 undef>
  %res = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_umax_failed(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @reduce_umax_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <2 x i32> [[X:%.*]], <2 x i32> [[Y:%.*]], <4 x i32> <i32 2, i32 1, i32 3, i32 0>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <2 x i32> %x, <2 x i32> %y, <4 x i32> <i32 2, i32 1, i32 3, i32 0>
  %res = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_umin_failed(<2 x i32> %x) {
; CHECK-LABEL: @reduce_umin_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <2 x i32> [[X:%.*]], <2 x i32> poison, <4 x i32> <i32 poison, i32 poison, i32 0, i32 1>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <2 x i32> %x, <2 x i32> poison, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %res = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_smax_failed(<8 x i32> %x) {
; CHECK-LABEL: @reduce_smax_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <8 x i32> [[X:%.*]], <8 x i32> poison, <4 x i32> <i32 2, i32 0, i32 3, i32 1>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <8 x i32> %x, <8 x i32> poison, <4 x i32> <i32 2, i32 0, i32 3, i32 1>
  %res = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define i32 @reduce_smin_failed(<8 x i32> %x) {
; CHECK-LABEL: @reduce_smin_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <8 x i32> [[X:%.*]], <8 x i32> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
; CHECK-NEXT:    [[RES:%.*]] = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> [[SHUF]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %shuf = shufflevector <8 x i32> %x, <8 x i32> %x, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %shuf)
  ret i32 %res
}

define float @reduce_fmax_failed(<4 x float> %x) {
; CHECK-LABEL: @reduce_fmax_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> poison, <4 x i32> <i32 2, i32 2, i32 3, i32 1>
; CHECK-NEXT:    [[RES:%.*]] = call float @llvm.vector.reduce.fmax.v4f32(<4 x float> [[SHUF]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> <i32 2, i32 2, i32 3, i32 1>
  %res = call float @llvm.vector.reduce.fmax.v4f32(<4 x float> %shuf)
  ret float %res
}

define float @reduce_fmin_failed(<4 x float> %x) {
; CHECK-LABEL: @reduce_fmin_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> poison, <4 x i32> <i32 poison, i32 3, i32 1, i32 2>
; CHECK-NEXT:    [[RES:%.*]] = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> [[SHUF]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> <i32 poison, i32 3, i32 1, i32 2>
  %res = call float @llvm.vector.reduce.fmin.v4f32(<4 x float> %shuf)
  ret float %res
}

define float @reduce_fadd_failed(float %a, <4 x float> %x) {
; CHECK-LABEL: @reduce_fadd_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
; CHECK-NEXT:    [[RES:%.*]] = call float @llvm.vector.reduce.fadd.v4f32(float [[A:%.*]], <4 x float> [[SHUF]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call float @llvm.vector.reduce.fadd.v4f32(float %a, <4 x float> %shuf)
  ret float %res
}

define float @reduce_fmul_failed(float %a, <2 x float> %x) {
; CHECK-LABEL: @reduce_fmul_failed(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <2 x float> [[X:%.*]], <2 x float> poison, <4 x i32> <i32 0, i32 poison, i32 1, i32 poison>
; CHECK-NEXT:    [[RES:%.*]] = call float @llvm.vector.reduce.fmul.v4f32(float [[A:%.*]], <4 x float> [[SHUF]])
; CHECK-NEXT:    ret float [[RES]]
;
  %shuf = shufflevector <2 x float> %x, <2 x float> poison, <4 x i32> <i32 0, i32 3, i32 1, i32 2>
  %res = call float @llvm.vector.reduce.fmul.v4f32(float %a, <4 x float> %shuf)
  ret float %res
}

declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.or.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.and.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %a)
declare i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %a)
declare float @llvm.vector.reduce.fmax.v4f32(<4 x float> %a)
declare float @llvm.vector.reduce.fmin.v4f32(<4 x float> %a)
declare float @llvm.vector.reduce.fadd.v4f32(float %a, <4 x float> %b)
declare float @llvm.vector.reduce.fmul.v4f32(float %a, <4 x float> %b)
