; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr7 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix LE-LINUX-P7
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix LE-LINUX-P8
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr7 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix BE-LINUX-P7
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix BE-LINUX-P8
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix \
; RUN:   -mcpu=pwr7 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix AIX64-P7
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix \
; RUN:   -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix AIX64-P8
; RUN: llc -verify-machineinstrs -mtriple=powerpc-ibm-aix \
; RUN:   -mcpu=pwr7 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix AIX32-P7
; RUN: llc -verify-machineinstrs -mtriple=powerpc-ibm-aix \
; RUN:   -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -O0 --data-sections < %s | FileCheck %s --check-prefix AIX32-P8

;; Note that the above run lines all use -O0 because this causes the spill that
;; exposed the issue in the first place. Higher opt levels will remove the spills
;; and as a result will not expose the issue.

define dso_local void @caller() #0 {
; LE-LINUX-P7-LABEL: caller:
; LE-LINUX-P7:       # %bb.0: # %entry
; LE-LINUX-P7-NEXT:    mflr r0
; LE-LINUX-P7-NEXT:    stdu r1, -112(r1)
; LE-LINUX-P7-NEXT:    std r0, 128(r1)
; LE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_1@toc@ha
; LE-LINUX-P7-NEXT:    lfs f1, .LCPI0_1@toc@l(r3)
; LE-LINUX-P7-NEXT:    bl callee
; LE-LINUX-P7-NEXT:    nop
; LE-LINUX-P7-NEXT:    stfs f1, 100(r1) # 4-byte Folded Spill
; LE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_1@toc@ha
; LE-LINUX-P7-NEXT:    lfs f1, .LCPI0_1@toc@l(r3)
; LE-LINUX-P7-NEXT:    bl callee
; LE-LINUX-P7-NEXT:    nop
; LE-LINUX-P7-NEXT:    fmr f2, f1
; LE-LINUX-P7-NEXT:    lfs f1, 100(r1) # 4-byte Folded Reload
; LE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; LE-LINUX-P7-NEXT:    lfs f0, .LCPI0_0@toc@l(r3)
; LE-LINUX-P7-NEXT:    fmuls f0, f0, f2
; LE-LINUX-P7-NEXT:    stfs f1, 104(r1)
; LE-LINUX-P7-NEXT:    stfs f0, 108(r1)
; LE-LINUX-P7-NEXT:    addi r1, r1, 112
; LE-LINUX-P7-NEXT:    ld r0, 16(r1)
; LE-LINUX-P7-NEXT:    mtlr r0
; LE-LINUX-P7-NEXT:    blr
;
; LE-LINUX-P8-LABEL: caller:
; LE-LINUX-P8:       # %bb.0: # %entry
; LE-LINUX-P8-NEXT:    mflr r0
; LE-LINUX-P8-NEXT:    stdu r1, -64(r1)
; LE-LINUX-P8-NEXT:    std r0, 80(r1)
; LE-LINUX-P8-NEXT:    vspltisw v2, 1
; LE-LINUX-P8-NEXT:    xxlor vs0, v2, v2
; LE-LINUX-P8-NEXT:    xvcvsxwdp vs0, vs0
; LE-LINUX-P8-NEXT:    fmr f1, f0
; LE-LINUX-P8-NEXT:    li r3, 48
; LE-LINUX-P8-NEXT:    stxsspx f1, r1, r3 # 4-byte Folded Spill
; LE-LINUX-P8-NEXT:    bl callee
; LE-LINUX-P8-NEXT:    nop
; LE-LINUX-P8-NEXT:    fmr f0, f1
; LE-LINUX-P8-NEXT:    li r3, 48
; LE-LINUX-P8-NEXT:    lxsspx f1, r1, r3 # 4-byte Folded Reload
; LE-LINUX-P8-NEXT:    stfs f0, 52(r1) # 4-byte Folded Spill
; LE-LINUX-P8-NEXT:    bl callee
; LE-LINUX-P8-NEXT:    nop
; LE-LINUX-P8-NEXT:    fmr f0, f1
; LE-LINUX-P8-NEXT:    lfs f1, 52(r1) # 4-byte Folded Reload
; LE-LINUX-P8-NEXT:    xsaddsp f0, f0, f0
; LE-LINUX-P8-NEXT:    stfs f1, 56(r1)
; LE-LINUX-P8-NEXT:    stfs f0, 60(r1)
; LE-LINUX-P8-NEXT:    addi r1, r1, 64
; LE-LINUX-P8-NEXT:    ld r0, 16(r1)
; LE-LINUX-P8-NEXT:    mtlr r0
; LE-LINUX-P8-NEXT:    blr
;
; BE-LINUX-P7-LABEL: caller:
; BE-LINUX-P7:       # %bb.0: # %entry
; BE-LINUX-P7-NEXT:    mflr r0
; BE-LINUX-P7-NEXT:    stdu r1, -128(r1)
; BE-LINUX-P7-NEXT:    std r0, 144(r1)
; BE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_1@toc@ha
; BE-LINUX-P7-NEXT:    lfs f1, .LCPI0_1@toc@l(r3)
; BE-LINUX-P7-NEXT:    bl callee
; BE-LINUX-P7-NEXT:    nop
; BE-LINUX-P7-NEXT:    stfs f1, 116(r1) # 4-byte Folded Spill
; BE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_1@toc@ha
; BE-LINUX-P7-NEXT:    lfs f1, .LCPI0_1@toc@l(r3)
; BE-LINUX-P7-NEXT:    bl callee
; BE-LINUX-P7-NEXT:    nop
; BE-LINUX-P7-NEXT:    fmr f2, f1
; BE-LINUX-P7-NEXT:    lfs f1, 116(r1) # 4-byte Folded Reload
; BE-LINUX-P7-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; BE-LINUX-P7-NEXT:    lfs f0, .LCPI0_0@toc@l(r3)
; BE-LINUX-P7-NEXT:    fmuls f0, f0, f2
; BE-LINUX-P7-NEXT:    stfs f1, 120(r1)
; BE-LINUX-P7-NEXT:    stfs f0, 124(r1)
; BE-LINUX-P7-NEXT:    addi r1, r1, 128
; BE-LINUX-P7-NEXT:    ld r0, 16(r1)
; BE-LINUX-P7-NEXT:    mtlr r0
; BE-LINUX-P7-NEXT:    blr
;
; BE-LINUX-P8-LABEL: caller:
; BE-LINUX-P8:       # %bb.0: # %entry
; BE-LINUX-P8-NEXT:    mflr r0
; BE-LINUX-P8-NEXT:    stdu r1, -144(r1)
; BE-LINUX-P8-NEXT:    std r0, 160(r1)
; BE-LINUX-P8-NEXT:    vspltisw v2, 1
; BE-LINUX-P8-NEXT:    xxlor vs0, v2, v2
; BE-LINUX-P8-NEXT:    xvcvsxwdp vs0, vs0
; BE-LINUX-P8-NEXT:    fmr f1, f0
; BE-LINUX-P8-NEXT:    li r3, 128
; BE-LINUX-P8-NEXT:    stxsspx f1, r1, r3 # 4-byte Folded Spill
; BE-LINUX-P8-NEXT:    bl callee
; BE-LINUX-P8-NEXT:    nop
; BE-LINUX-P8-NEXT:    fmr f0, f1
; BE-LINUX-P8-NEXT:    li r3, 128
; BE-LINUX-P8-NEXT:    lxsspx f1, r1, r3 # 4-byte Folded Reload
; BE-LINUX-P8-NEXT:    stfs f0, 132(r1) # 4-byte Folded Spill
; BE-LINUX-P8-NEXT:    bl callee
; BE-LINUX-P8-NEXT:    nop
; BE-LINUX-P8-NEXT:    fmr f0, f1
; BE-LINUX-P8-NEXT:    lfs f1, 132(r1) # 4-byte Folded Reload
; BE-LINUX-P8-NEXT:    xsaddsp f0, f0, f0
; BE-LINUX-P8-NEXT:    stfs f1, 136(r1)
; BE-LINUX-P8-NEXT:    stfs f0, 140(r1)
; BE-LINUX-P8-NEXT:    addi r1, r1, 144
; BE-LINUX-P8-NEXT:    ld r0, 16(r1)
; BE-LINUX-P8-NEXT:    mtlr r0
; BE-LINUX-P8-NEXT:    blr
;
; AIX64-P7-LABEL: caller:
; AIX64-P7:       # %bb.0: # %entry
; AIX64-P7-NEXT:    mflr r0
; AIX64-P7-NEXT:    stdu r1, -128(r1)
; AIX64-P7-NEXT:    std r0, 144(r1)
; AIX64-P7-NEXT:    vspltisw v2, 1
; AIX64-P7-NEXT:    xxlor vs0, v2, v2
; AIX64-P7-NEXT:    xvcvsxwdp vs0, vs0
; AIX64-P7-NEXT:    fmr f1, f0
; AIX64-P7-NEXT:    bl .callee[PR]
; AIX64-P7-NEXT:    nop
; AIX64-P7-NEXT:    stfs f1, 116(r1) # 4-byte Folded Spill
; AIX64-P7-NEXT:    vspltisw v2, 1
; AIX64-P7-NEXT:    xxlor vs0, v2, v2
; AIX64-P7-NEXT:    xvcvsxwdp vs0, vs0
; AIX64-P7-NEXT:    fmr f1, f0
; AIX64-P7-NEXT:    bl .callee[PR]
; AIX64-P7-NEXT:    nop
; AIX64-P7-NEXT:    fmr f2, f1
; AIX64-P7-NEXT:    lfs f1, 116(r1) # 4-byte Folded Reload
; AIX64-P7-NEXT:    ld r3, L..C0(r2) # %const.0
; AIX64-P7-NEXT:    lfs f0, 0(r3)
; AIX64-P7-NEXT:    fmuls f0, f0, f2
; AIX64-P7-NEXT:    stfs f1, 120(r1)
; AIX64-P7-NEXT:    stfs f0, 124(r1)
; AIX64-P7-NEXT:    addi r1, r1, 128
; AIX64-P7-NEXT:    ld r0, 16(r1)
; AIX64-P7-NEXT:    mtlr r0
; AIX64-P7-NEXT:    blr
;
; AIX64-P8-LABEL: caller:
; AIX64-P8:       # %bb.0: # %entry
; AIX64-P8-NEXT:    mflr r0
; AIX64-P8-NEXT:    stdu r1, -144(r1)
; AIX64-P8-NEXT:    std r0, 160(r1)
; AIX64-P8-NEXT:    vspltisw v2, 1
; AIX64-P8-NEXT:    xxlor vs0, v2, v2
; AIX64-P8-NEXT:    xvcvsxwdp vs0, vs0
; AIX64-P8-NEXT:    fmr f1, f0
; AIX64-P8-NEXT:    li r3, 128
; AIX64-P8-NEXT:    stxsspx f1, r1, r3 # 4-byte Folded Spill
; AIX64-P8-NEXT:    bl .callee[PR]
; AIX64-P8-NEXT:    nop
; AIX64-P8-NEXT:    fmr f0, f1
; AIX64-P8-NEXT:    li r3, 128
; AIX64-P8-NEXT:    lxsspx f1, r1, r3 # 4-byte Folded Reload
; AIX64-P8-NEXT:    stfs f0, 132(r1) # 4-byte Folded Spill
; AIX64-P8-NEXT:    bl .callee[PR]
; AIX64-P8-NEXT:    nop
; AIX64-P8-NEXT:    fmr f0, f1
; AIX64-P8-NEXT:    lfs f1, 132(r1) # 4-byte Folded Reload
; AIX64-P8-NEXT:    xsaddsp f0, f0, f0
; AIX64-P8-NEXT:    stfs f1, 136(r1)
; AIX64-P8-NEXT:    stfs f0, 140(r1)
; AIX64-P8-NEXT:    addi r1, r1, 144
; AIX64-P8-NEXT:    ld r0, 16(r1)
; AIX64-P8-NEXT:    mtlr r0
; AIX64-P8-NEXT:    blr
;
; AIX32-P7-LABEL: caller:
; AIX32-P7:       # %bb.0: # %entry
; AIX32-P7-NEXT:    mflr r0
; AIX32-P7-NEXT:    stwu r1, -80(r1)
; AIX32-P7-NEXT:    stw r0, 88(r1)
; AIX32-P7-NEXT:    vspltisw v2, 1
; AIX32-P7-NEXT:    xxlor vs0, v2, v2
; AIX32-P7-NEXT:    xvcvsxwdp vs0, vs0
; AIX32-P7-NEXT:    fmr f1, f0
; AIX32-P7-NEXT:    stfs f1, 64(r1) # 4-byte Folded Spill
; AIX32-P7-NEXT:    bl .callee[PR]
; AIX32-P7-NEXT:    nop
; AIX32-P7-NEXT:    fmr f0, f1
; AIX32-P7-NEXT:    lfs f1, 64(r1) # 4-byte Folded Reload
; AIX32-P7-NEXT:    stfs f0, 68(r1) # 4-byte Folded Spill
; AIX32-P7-NEXT:    bl .callee[PR]
; AIX32-P7-NEXT:    nop
; AIX32-P7-NEXT:    fmr f0, f1
; AIX32-P7-NEXT:    lfs f1, 68(r1) # 4-byte Folded Reload
; AIX32-P7-NEXT:    fadds f0, f0, f0
; AIX32-P7-NEXT:    stfs f1, 72(r1)
; AIX32-P7-NEXT:    stfs f0, 76(r1)
; AIX32-P7-NEXT:    addi r1, r1, 80
; AIX32-P7-NEXT:    lwz r0, 8(r1)
; AIX32-P7-NEXT:    mtlr r0
; AIX32-P7-NEXT:    blr
;
; AIX32-P8-LABEL: caller:
; AIX32-P8:       # %bb.0: # %entry
; AIX32-P8-NEXT:    mflr r0
; AIX32-P8-NEXT:    stwu r1, -80(r1)
; AIX32-P8-NEXT:    stw r0, 88(r1)
; AIX32-P8-NEXT:    vspltisw v2, 1
; AIX32-P8-NEXT:    xxlor vs0, v2, v2
; AIX32-P8-NEXT:    xvcvsxwdp vs0, vs0
; AIX32-P8-NEXT:    fmr f1, f0
; AIX32-P8-NEXT:    li r3, 64
; AIX32-P8-NEXT:    stxsspx f1, r1, r3 # 4-byte Folded Spill
; AIX32-P8-NEXT:    bl .callee[PR]
; AIX32-P8-NEXT:    nop
; AIX32-P8-NEXT:    fmr f0, f1
; AIX32-P8-NEXT:    li r3, 64
; AIX32-P8-NEXT:    lxsspx f1, r1, r3 # 4-byte Folded Reload
; AIX32-P8-NEXT:    stfs f0, 68(r1) # 4-byte Folded Spill
; AIX32-P8-NEXT:    bl .callee[PR]
; AIX32-P8-NEXT:    nop
; AIX32-P8-NEXT:    fmr f0, f1
; AIX32-P8-NEXT:    lfs f1, 68(r1) # 4-byte Folded Reload
; AIX32-P8-NEXT:    xsaddsp f0, f0, f0
; AIX32-P8-NEXT:    stfs f1, 72(r1)
; AIX32-P8-NEXT:    stfs f0, 76(r1)
; AIX32-P8-NEXT:    addi r1, r1, 80
; AIX32-P8-NEXT:    lwz r0, 8(r1)
; AIX32-P8-NEXT:    mtlr r0
; AIX32-P8-NEXT:    blr
entry:
  %com1 = alloca { float, float }, align 8
  %0 = call contract float @callee(float 1.000000e+00)
  %1 = call contract float @callee(float 1.000000e+00)
  %mult = fmul contract float 2.000000e+00, %1
  %addr0 = getelementptr inbounds { float, float }, ptr %com1, i32 0, i32 0
  store float %0, ptr %addr0, align 4
  %addr1 = getelementptr inbounds { float, float }, ptr %com1, i32 0, i32 1
  store float %mult, ptr %addr1, align 4
  ret void
}

declare float @callee(float) #0

attributes #0 = { nounwind }
