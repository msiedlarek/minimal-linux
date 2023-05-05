; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

; This tests a mix of vfnmacc and vfnmadd by using different operand orders to
; trigger commuting in TwoAddressInstructionPass.

declare <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half>, <2 x half>, <2 x half>, metadata, metadata)

define <2 x half> @vfnmsub_vv_v2f16(<2 x half> %va, <2 x half> %vb, <2 x half> %vc) {
; CHECK-LABEL: vfnmsub_vv_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v10, v9
; CHECK-NEXT:    ret
  %neg = fneg <2 x half> %va
  %neg2 = fneg <2 x half> %vb
  %vd = call <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half> %neg, <2 x half> %vc, <2 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x half> %vd
}

define <2 x half> @vfnmsub_vf_v2f16(<2 x half> %va, <2 x half> %vb, half %c) {
; CHECK-LABEL: vfnmsub_vf_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <2 x half> poison, half %c, i32 0
  %splat = shufflevector <2 x half> %head, <2 x half> poison, <2 x i32> zeroinitializer
  %neg = fneg <2 x half> %va
  %neg2 = fneg <2 x half> %vb
  %vd = call <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half> %splat, <2 x half> %neg, <2 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x half> %vd
}

declare <4 x half> @llvm.experimental.constrained.fma.v4f16(<4 x half>, <4 x half>, <4 x half>, metadata, metadata)

define <4 x half> @vfnmsub_vv_v4f16(<4 x half> %va, <4 x half> %vb, <4 x half> %vc) {
; CHECK-LABEL: vfnmsub_vv_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
  %neg = fneg <4 x half> %vb
  %neg2 = fneg <4 x half> %vc
  %vd = call <4 x half> @llvm.experimental.constrained.fma.v4f16(<4 x half> %neg, <4 x half> %va, <4 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x half> %vd
}

define <4 x half> @vfnmsub_vf_v4f16(<4 x half> %va, <4 x half> %vb, half %c) {
; CHECK-LABEL: vfnmsub_vf_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <4 x half> poison, half %c, i32 0
  %splat = shufflevector <4 x half> %head, <4 x half> poison, <4 x i32> zeroinitializer
  %neg = fneg <4 x half> %splat
  %neg2 = fneg <4 x half> %vb
  %vd = call <4 x half> @llvm.experimental.constrained.fma.v4f16(<4 x half> %va, <4 x half> %neg, <4 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x half> %vd
}

declare <8 x half> @llvm.experimental.constrained.fma.v8f16(<8 x half>, <8 x half>, <8 x half>, metadata, metadata)

define <8 x half> @vfnmsub_vv_v8f16(<8 x half> %va, <8 x half> %vb, <8 x half> %vc) {
; CHECK-LABEL: vfnmsub_vv_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfnmacc.vv v8, v10, v9
; CHECK-NEXT:    ret
  %neg = fneg <8 x half> %vb
  %neg2 = fneg <8 x half> %va
  %vd = call <8 x half> @llvm.experimental.constrained.fma.v8f16(<8 x half> %neg, <8 x half> %vc, <8 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x half> %vd
}

define <8 x half> @vfnmsub_vf_v8f16(<8 x half> %va, <8 x half> %vb, half %c) {
; CHECK-LABEL: vfnmsub_vf_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfnmacc.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <8 x half> poison, half %c, i32 0
  %splat = shufflevector <8 x half> %head, <8 x half> poison, <8 x i32> zeroinitializer
  %neg = fneg <8 x half> %splat
  %neg2 = fneg <8 x half> %va
  %vd = call <8 x half> @llvm.experimental.constrained.fma.v8f16(<8 x half> %vb, <8 x half> %neg, <8 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x half> %vd
}

declare <16 x half> @llvm.experimental.constrained.fma.v16f16(<16 x half>, <16 x half>, <16 x half>, metadata, metadata)

define <16 x half> @vfnmsub_vv_v16f16(<16 x half> %va, <16 x half> %vb, <16 x half> %vc) {
; CHECK-LABEL: vfnmsub_vv_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v12, v10
; CHECK-NEXT:    ret
  %neg = fneg <16 x half> %vc
  %neg2 = fneg <16 x half> %vb
  %vd = call <16 x half> @llvm.experimental.constrained.fma.v16f16(<16 x half> %neg, <16 x half> %va, <16 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <16 x half> %vd
}

define <16 x half> @vfnmsub_vf_v16f16(<16 x half> %va, <16 x half> %vb, half %c) {
; CHECK-LABEL: vfnmsub_vf_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v10
; CHECK-NEXT:    ret
  %head = insertelement <16 x half> poison, half %c, i32 0
  %splat = shufflevector <16 x half> %head, <16 x half> poison, <16 x i32> zeroinitializer
  %neg = fneg <16 x half> %splat
  %neg2 = fneg <16 x half> %vb
  %vd = call <16 x half> @llvm.experimental.constrained.fma.v16f16(<16 x half> %neg, <16 x half> %va, <16 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <16 x half> %vd
}

declare <32 x half> @llvm.experimental.constrained.fma.v32f16(<32 x half>, <32 x half>, <32 x half>, metadata, metadata)

define <32 x half> @vfnmsub_vv_v32f16(<32 x half> %va, <32 x half> %vb, <32 x half> %vc) {
; CHECK-LABEL: vfnmsub_vv_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v16, v12
; CHECK-NEXT:    ret
  %neg = fneg <32 x half> %vc
  %neg2 = fneg <32 x half> %vb
  %vd = call <32 x half> @llvm.experimental.constrained.fma.v32f16(<32 x half> %neg, <32 x half> %va, <32 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <32 x half> %vd
}

define <32 x half> @vfnmsub_vf_v32f16(<32 x half> %va, <32 x half> %vb, half %c) {
; CHECK-LABEL: vfnmsub_vf_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vfnmacc.vf v8, fa0, v12
; CHECK-NEXT:    ret
  %head = insertelement <32 x half> poison, half %c, i32 0
  %splat = shufflevector <32 x half> %head, <32 x half> poison, <32 x i32> zeroinitializer
  %neg = fneg <32 x half> %splat
  %neg2 = fneg <32 x half> %va
  %vd = call <32 x half> @llvm.experimental.constrained.fma.v32f16(<32 x half> %neg, <32 x half> %vb, <32 x half> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <32 x half> %vd
}

declare <2 x float> @llvm.experimental.constrained.fma.v2f32(<2 x float>, <2 x float>, <2 x float>, metadata, metadata)

define <2 x float> @vfnmsub_vv_v2f32(<2 x float> %va, <2 x float> %vb, <2 x float> %vc) {
; CHECK-LABEL: vfnmsub_vv_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v10, v9
; CHECK-NEXT:    ret
  %neg = fneg <2 x float> %vc
  %neg2 = fneg <2 x float> %vb
  %vd = call <2 x float> @llvm.experimental.constrained.fma.v2f32(<2 x float> %va, <2 x float> %neg, <2 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x float> %vd
}

define <2 x float> @vfnmsub_vf_v2f32(<2 x float> %va, <2 x float> %vb, float %c) {
; CHECK-LABEL: vfnmsub_vf_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <2 x float> poison, float %c, i32 0
  %splat = shufflevector <2 x float> %head, <2 x float> poison, <2 x i32> zeroinitializer
  %neg = fneg <2 x float> %va
  %neg2 = fneg <2 x float> %vb
  %vd = call <2 x float> @llvm.experimental.constrained.fma.v2f32(<2 x float> %splat, <2 x float> %neg, <2 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x float> %vd
}

declare <4 x float> @llvm.experimental.constrained.fma.v4f32(<4 x float>, <4 x float>, <4 x float>, metadata, metadata)

define <4 x float> @vfnmsub_vv_v4f32(<4 x float> %va, <4 x float> %vb, <4 x float> %vc) {
; CHECK-LABEL: vfnmsub_vv_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
  %neg = fneg <4 x float> %va
  %neg2 = fneg <4 x float> %vc
  %vd = call <4 x float> @llvm.experimental.constrained.fma.v4f32(<4 x float> %vb, <4 x float> %neg, <4 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x float> %vd
}

define <4 x float> @vfnmsub_vf_v4f32(<4 x float> %va, <4 x float> %vb, float %c) {
; CHECK-LABEL: vfnmsub_vf_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <4 x float> poison, float %c, i32 0
  %splat = shufflevector <4 x float> %head, <4 x float> poison, <4 x i32> zeroinitializer
  %neg = fneg <4 x float> %splat
  %neg2 = fneg <4 x float> %vb
  %vd = call <4 x float> @llvm.experimental.constrained.fma.v4f32(<4 x float> %va, <4 x float> %neg, <4 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x float> %vd
}

declare <8 x float> @llvm.experimental.constrained.fma.v8f32(<8 x float>, <8 x float>, <8 x float>, metadata, metadata)

define <8 x float> @vfnmsub_vv_v8f32(<8 x float> %va, <8 x float> %vb, <8 x float> %vc) {
; CHECK-LABEL: vfnmsub_vv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfnmacc.vv v8, v12, v10
; CHECK-NEXT:    ret
  %neg = fneg <8 x float> %vc
  %neg2 = fneg <8 x float> %va
  %vd = call <8 x float> @llvm.experimental.constrained.fma.v8f32(<8 x float> %vb, <8 x float> %neg, <8 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x float> %vd
}

define <8 x float> @vfnmsub_vf_v8f32(<8 x float> %va, <8 x float> %vb, float %c) {
; CHECK-LABEL: vfnmsub_vf_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfnmacc.vf v8, fa0, v10
; CHECK-NEXT:    ret
  %head = insertelement <8 x float> poison, float %c, i32 0
  %splat = shufflevector <8 x float> %head, <8 x float> poison, <8 x i32> zeroinitializer
  %neg = fneg <8 x float> %splat
  %neg2 = fneg <8 x float> %va
  %vd = call <8 x float> @llvm.experimental.constrained.fma.v8f32(<8 x float> %vb, <8 x float> %neg, <8 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x float> %vd
}

declare <16 x float> @llvm.experimental.constrained.fma.v16f32(<16 x float>, <16 x float>, <16 x float>, metadata, metadata)

define <16 x float> @vfnmsub_vv_v16f32(<16 x float> %va, <16 x float> %vb, <16 x float> %vc) {
; CHECK-LABEL: vfnmsub_vv_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v16, v12
; CHECK-NEXT:    ret
  %neg = fneg <16 x float> %va
  %neg2 = fneg <16 x float> %vb
  %vd = call <16 x float> @llvm.experimental.constrained.fma.v16f32(<16 x float> %vc, <16 x float> %neg, <16 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <16 x float> %vd
}

define <16 x float> @vfnmsub_vf_v16f32(<16 x float> %va, <16 x float> %vb, float %c) {
; CHECK-LABEL: vfnmsub_vf_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v12
; CHECK-NEXT:    ret
  %head = insertelement <16 x float> poison, float %c, i32 0
  %splat = shufflevector <16 x float> %head, <16 x float> poison, <16 x i32> zeroinitializer
  %neg = fneg <16 x float> %splat
  %neg2 = fneg <16 x float> %vb
  %vd = call <16 x float> @llvm.experimental.constrained.fma.v16f32(<16 x float> %neg, <16 x float> %va, <16 x float> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <16 x float> %vd
}

declare <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double>, <2 x double>, <2 x double>, metadata, metadata)

define <2 x double> @vfnmsub_vv_v2f64(<2 x double> %va, <2 x double> %vb, <2 x double> %vc) {
; CHECK-LABEL: vfnmsub_vv_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v10, v9
; CHECK-NEXT:    ret
  %neg = fneg <2 x double> %va
  %neg2 = fneg <2 x double> %vb
  %vd = call <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double> %neg, <2 x double> %vc, <2 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x double> %vd
}

define <2 x double> @vfnmsub_vf_v2f64(<2 x double> %va, <2 x double> %vb, double %c) {
; CHECK-LABEL: vfnmsub_vf_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <2 x double> poison, double %c, i32 0
  %splat = shufflevector <2 x double> %head, <2 x double> poison, <2 x i32> zeroinitializer
  %neg = fneg <2 x double> %va
  %neg2 = fneg <2 x double> %vb
  %vd = call <2 x double> @llvm.experimental.constrained.fma.v2f64(<2 x double> %splat, <2 x double> %neg, <2 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <2 x double> %vd
}

declare <4 x double> @llvm.experimental.constrained.fma.v4f64(<4 x double>, <4 x double>, <4 x double>, metadata, metadata)

define <4 x double> @vfnmsub_vv_v4f64(<4 x double> %va, <4 x double> %vb, <4 x double> %vc) {
; CHECK-LABEL: vfnmsub_vv_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12
; CHECK-NEXT:    ret
  %neg = fneg <4 x double> %vb
  %neg2 = fneg <4 x double> %vc
  %vd = call <4 x double> @llvm.experimental.constrained.fma.v4f64(<4 x double> %neg, <4 x double> %va, <4 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x double> %vd
}

define <4 x double> @vfnmsub_vf_v4f64(<4 x double> %va, <4 x double> %vb, double %c) {
; CHECK-LABEL: vfnmsub_vf_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfnmadd.vf v8, fa0, v10
; CHECK-NEXT:    ret
  %head = insertelement <4 x double> poison, double %c, i32 0
  %splat = shufflevector <4 x double> %head, <4 x double> poison, <4 x i32> zeroinitializer
  %neg = fneg <4 x double> %splat
  %neg2 = fneg <4 x double> %vb
  %vd = call <4 x double> @llvm.experimental.constrained.fma.v4f64(<4 x double> %va, <4 x double> %neg, <4 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <4 x double> %vd
}

declare <8 x double> @llvm.experimental.constrained.fma.v8f64(<8 x double>, <8 x double>, <8 x double>, metadata, metadata)

define <8 x double> @vfnmsub_vv_v8f64(<8 x double> %va, <8 x double> %vb, <8 x double> %vc) {
; CHECK-LABEL: vfnmsub_vv_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfnmacc.vv v8, v16, v12
; CHECK-NEXT:    ret
  %neg = fneg <8 x double> %vb
  %neg2 = fneg <8 x double> %va
  %vd = call <8 x double> @llvm.experimental.constrained.fma.v8f64(<8 x double> %neg, <8 x double> %vc, <8 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x double> %vd
}

define <8 x double> @vfnmsub_vf_v8f64(<8 x double> %va, <8 x double> %vb, double %c) {
; CHECK-LABEL: vfnmsub_vf_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfnmacc.vf v8, fa0, v12
; CHECK-NEXT:    ret
  %head = insertelement <8 x double> poison, double %c, i32 0
  %splat = shufflevector <8 x double> %head, <8 x double> poison, <8 x i32> zeroinitializer
  %neg = fneg <8 x double> %splat
  %neg2 = fneg <8 x double> %va
  %vd = call <8 x double> @llvm.experimental.constrained.fma.v8f64(<8 x double> %vb, <8 x double> %neg, <8 x double> %neg2, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <8 x double> %vd
}