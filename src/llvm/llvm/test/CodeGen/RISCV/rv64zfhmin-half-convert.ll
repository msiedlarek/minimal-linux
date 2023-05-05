; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s -check-prefix=RV64IZFHMIN

; This file exhaustively checks half<->i32 conversions.

define i32 @aext_fptosi(half %a) nounwind {
; RV64IZFHMIN-LABEL: aext_fptosi:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.w.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    ret
  %1 = fptosi half %a to i32
  ret i32 %1
}

define signext i32 @sext_fptosi(half %a) nounwind {
; RV64IZFHMIN-LABEL: sext_fptosi:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.w.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    ret
  %1 = fptosi half %a to i32
  ret i32 %1
}

define zeroext i32 @zext_fptosi(half %a) nounwind {
; RV64IZFHMIN-LABEL: zext_fptosi:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.w.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    slli a0, a0, 32
; RV64IZFHMIN-NEXT:    srli a0, a0, 32
; RV64IZFHMIN-NEXT:    ret
  %1 = fptosi half %a to i32
  ret i32 %1
}

define i32 @aext_fptoui(half %a) nounwind {
; RV64IZFHMIN-LABEL: aext_fptoui:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.wu.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    ret
  %1 = fptoui half %a to i32
  ret i32 %1
}

define signext i32 @sext_fptoui(half %a) nounwind {
; RV64IZFHMIN-LABEL: sext_fptoui:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.wu.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    ret
  %1 = fptoui half %a to i32
  ret i32 %1
}

define zeroext i32 @zext_fptoui(half %a) nounwind {
; RV64IZFHMIN-LABEL: zext_fptoui:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; RV64IZFHMIN-NEXT:    fcvt.lu.s a0, fa5, rtz
; RV64IZFHMIN-NEXT:    ret
  %1 = fptoui half %a to i32
  ret i32 %1
}

define i16 @bcvt_f16_to_aext_i16(half %a, half %b) nounwind {
; RV64IZFHMIN-LABEL: bcvt_f16_to_aext_i16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; RV64IZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; RV64IZFHMIN-NEXT:    fadd.s fa5, fa4, fa5
; RV64IZFHMIN-NEXT:    fcvt.h.s fa5, fa5
; RV64IZFHMIN-NEXT:    fmv.x.h a0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = fadd half %a, %b
  %2 = bitcast half %1 to i16
  ret i16 %2
}

define signext i16 @bcvt_f16_to_sext_i16(half %a, half %b) nounwind {
; RV64IZFHMIN-LABEL: bcvt_f16_to_sext_i16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; RV64IZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; RV64IZFHMIN-NEXT:    fadd.s fa5, fa4, fa5
; RV64IZFHMIN-NEXT:    fcvt.h.s fa5, fa5
; RV64IZFHMIN-NEXT:    fmv.x.h a0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = fadd half %a, %b
  %2 = bitcast half %1 to i16
  ret i16 %2
}

define zeroext i16 @bcvt_f16_to_zext_i16(half %a, half %b) nounwind {
; RV64IZFHMIN-LABEL: bcvt_f16_to_zext_i16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; RV64IZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; RV64IZFHMIN-NEXT:    fadd.s fa5, fa4, fa5
; RV64IZFHMIN-NEXT:    fcvt.h.s fa5, fa5
; RV64IZFHMIN-NEXT:    fmv.x.h a0, fa5
; RV64IZFHMIN-NEXT:    slli a0, a0, 48
; RV64IZFHMIN-NEXT:    srli a0, a0, 48
; RV64IZFHMIN-NEXT:    ret
  %1 = fadd half %a, %b
  %2 = bitcast half %1 to i16
  ret i16 %2
}

define half @bcvt_i64_to_f16_via_i16(i64 %a, i64 %b) nounwind {
; RV64IZFHMIN-LABEL: bcvt_i64_to_f16_via_i16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fmv.h.x fa5, a0
; RV64IZFHMIN-NEXT:    fmv.h.x fa4, a1
; RV64IZFHMIN-NEXT:    fcvt.s.h fa4, fa4
; RV64IZFHMIN-NEXT:    fcvt.s.h fa5, fa5
; RV64IZFHMIN-NEXT:    fadd.s fa5, fa5, fa4
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = trunc i64 %a to i16
  %2 = trunc i64 %b to i16
  %3 = bitcast i16 %1 to half
  %4 = bitcast i16 %2 to half
  %5 = fadd half %3, %4
  ret half %5
}

define half @uitofp_aext_i32_to_f16(i32 %a) nounwind {
; RV64IZFHMIN-LABEL: uitofp_aext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    slli a0, a0, 32
; RV64IZFHMIN-NEXT:    srli a0, a0, 32
; RV64IZFHMIN-NEXT:    fcvt.s.lu fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = uitofp i32 %a to half
  ret half %1
}

define half @uitofp_sext_i32_to_f16(i32 signext %a) nounwind {
; RV64IZFHMIN-LABEL: uitofp_sext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    slli a0, a0, 32
; RV64IZFHMIN-NEXT:    srli a0, a0, 32
; RV64IZFHMIN-NEXT:    fcvt.s.lu fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = uitofp i32 %a to half
  ret half %1
}

define half @uitofp_zext_i32_to_f16(i32 zeroext %a) nounwind {
; RV64IZFHMIN-LABEL: uitofp_zext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.lu fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = uitofp i32 %a to half
  ret half %1
}

define half @sitofp_aext_i32_to_f16(i32 %a) nounwind {
; RV64IZFHMIN-LABEL: sitofp_aext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    sext.w a0, a0
; RV64IZFHMIN-NEXT:    fcvt.s.l fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = sitofp i32 %a to half
  ret half %1
}

define half @sitofp_sext_i32_to_f16(i32 signext %a) nounwind {
; RV64IZFHMIN-LABEL: sitofp_sext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    fcvt.s.l fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = sitofp i32 %a to half
  ret half %1
}

define half @sitofp_zext_i32_to_f16(i32 zeroext %a) nounwind {
; RV64IZFHMIN-LABEL: sitofp_zext_i32_to_f16:
; RV64IZFHMIN:       # %bb.0:
; RV64IZFHMIN-NEXT:    sext.w a0, a0
; RV64IZFHMIN-NEXT:    fcvt.s.l fa5, a0
; RV64IZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; RV64IZFHMIN-NEXT:    ret
  %1 = sitofp i32 %a to half
  ret half %1
}