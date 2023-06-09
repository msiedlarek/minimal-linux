; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zfhmin -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32f | FileCheck -check-prefix=CHECKIZFHMIN %s
; RUN: llc -mtriple=riscv64 -mattr=+zfhmin -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64f | FileCheck -check-prefix=CHECKIZFHMIN %s

define half @select_icmp_eq(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    beq a0, a1, .LBB0_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_eq:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    beq a0, a1, .LBB0_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB0_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp eq i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_ne(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bne a0, a1, .LBB1_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_ne:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bne a0, a1, .LBB1_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB1_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp ne i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_ugt(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_ugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bltu a1, a0, .LBB2_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_ugt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bltu a1, a0, .LBB2_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB2_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp ugt i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_uge(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_uge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bgeu a0, a1, .LBB3_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_uge:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bgeu a0, a1, .LBB3_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB3_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp uge i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_ult(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_ult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bltu a0, a1, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_ult:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bltu a0, a1, .LBB4_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB4_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp ult i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_ule(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_ule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bgeu a1, a0, .LBB5_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_ule:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bgeu a1, a0, .LBB5_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB5_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp ule i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_sgt(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_sgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    blt a1, a0, .LBB6_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB6_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_sgt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    blt a1, a0, .LBB6_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB6_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp sgt i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_sge(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_sge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bge a0, a1, .LBB7_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_sge:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bge a0, a1, .LBB7_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB7_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp sge i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_slt(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_slt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    blt a0, a1, .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_slt:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    blt a0, a1, .LBB8_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB8_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp slt i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}

define half @select_icmp_sle(i32 signext %a, i32 signext %b, half %c, half %d) {
; CHECK-LABEL: select_icmp_sle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    bge a1, a0, .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    fmv.h fa0, fa1
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    ret
;
; CHECKIZFHMIN-LABEL: select_icmp_sle:
; CHECKIZFHMIN:       # %bb.0:
; CHECKIZFHMIN-NEXT:    bge a1, a0, .LBB9_2
; CHECKIZFHMIN-NEXT:  # %bb.1:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
; CHECKIZFHMIN-NEXT:  .LBB9_2:
; CHECKIZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; CHECKIZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; CHECKIZFHMIN-NEXT:    ret
  %1 = icmp sle i32 %a, %b
  %2 = select i1 %1, half %c, half %d
  ret half %2
}
