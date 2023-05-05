; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32d | FileCheck -check-prefix=CHECKIFD %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64d | FileCheck -check-prefix=CHECKIFD %s
; RUN: llc -mtriple=riscv64 -mattr=+zdinx -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64 | FileCheck -check-prefix=CHECKIZFINXZDINX %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

define i32 @fcmp_false(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_false:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    li a0, 0
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_false:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    li a0, 0
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_false:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_false:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    ret
  %1 = fcmp false double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_oeq(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_oeq:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    feq.d a0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_oeq:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    feq.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_oeq:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __eqdf2@plt
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_oeq:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __eqdf2@plt
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp oeq double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ogt(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ogt:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa1, fa0
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ogt:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ogt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __gtdf2@plt
; RV32I-NEXT:    sgtz a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ogt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gtdf2@plt
; RV64I-NEXT:    sgtz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ogt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_oge(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_oge:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fle.d a0, fa1, fa0
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_oge:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    fle.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_oge:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __gedf2@plt
; RV32I-NEXT:    slti a0, a0, 0
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_oge:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gedf2@plt
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    xori a0, a0, 1
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp oge double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_olt(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_olt:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_olt:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_olt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ltdf2@plt
; RV32I-NEXT:    slti a0, a0, 0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_olt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __ltdf2@plt
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp olt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ole(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ole:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fle.d a0, fa0, fa1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ole:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    fle.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ole:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ledf2@plt
; RV32I-NEXT:    slti a0, a0, 1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ole:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __ledf2@plt
; RV64I-NEXT:    slti a0, a0, 1
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ole double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_one(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_one:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa0, fa1
; CHECKIFD-NEXT:    flt.d a1, fa1, fa0
; CHECKIFD-NEXT:    or a0, a1, a0
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_one:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a2, a0, a1
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    or a0, a0, a2
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_one:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a3
; RV32I-NEXT:    mv s1, a2
; RV32I-NEXT:    mv s2, a1
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    call __eqdf2@plt
; RV32I-NEXT:    snez s4, a0
; RV32I-NEXT:    mv a0, s3
; RV32I-NEXT:    mv a1, s2
; RV32I-NEXT:    mv a2, s1
; RV32I-NEXT:    mv a3, s0
; RV32I-NEXT:    call __unorddf2@plt
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    and a0, a0, s4
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_one:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    call __eqdf2@plt
; RV64I-NEXT:    snez s2, a0
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    mv a1, s0
; RV64I-NEXT:    call __unorddf2@plt
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    and a0, a0, s2
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %1 = fcmp one double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ord(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ord:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    feq.d a0, fa1, fa1
; CHECKIFD-NEXT:    feq.d a1, fa0, fa0
; CHECKIFD-NEXT:    and a0, a1, a0
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ord:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    feq.d a1, a1, a1
; CHECKIZFINXZDINX-NEXT:    feq.d a0, a0, a0
; CHECKIZFINXZDINX-NEXT:    and a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ord:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __unorddf2@plt
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ord:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __unorddf2@plt
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ord double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ueq(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ueq:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa0, fa1
; CHECKIFD-NEXT:    flt.d a1, fa1, fa0
; CHECKIFD-NEXT:    or a0, a1, a0
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ueq:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a2, a0, a1
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    or a0, a0, a2
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ueq:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a3
; RV32I-NEXT:    mv s1, a2
; RV32I-NEXT:    mv s2, a1
; RV32I-NEXT:    mv s3, a0
; RV32I-NEXT:    call __eqdf2@plt
; RV32I-NEXT:    seqz s4, a0
; RV32I-NEXT:    mv a0, s3
; RV32I-NEXT:    mv a1, s2
; RV32I-NEXT:    mv a2, s1
; RV32I-NEXT:    mv a3, s0
; RV32I-NEXT:    call __unorddf2@plt
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    or a0, a0, s4
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ueq:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    call __eqdf2@plt
; RV64I-NEXT:    seqz s2, a0
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    mv a1, s0
; RV64I-NEXT:    call __unorddf2@plt
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    or a0, a0, s2
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %1 = fcmp ueq double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ugt(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ugt:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fle.d a0, fa0, fa1
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ugt:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    fle.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ugt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ledf2@plt
; RV32I-NEXT:    sgtz a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ugt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __ledf2@plt
; RV64I-NEXT:    sgtz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ugt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_uge(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_uge:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa0, fa1
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_uge:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_uge:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ltdf2@plt
; RV32I-NEXT:    slti a0, a0, 0
; RV32I-NEXT:    xori a0, a0, 1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_uge:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __ltdf2@plt
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    xori a0, a0, 1
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp uge double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ult(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ult:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fle.d a0, fa1, fa0
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ult:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    fle.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ult:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __gedf2@plt
; RV32I-NEXT:    slti a0, a0, 0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ult:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gedf2@plt
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ult double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ule(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_ule:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    flt.d a0, fa1, fa0
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_ule:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    flt.d a0, a1, a0
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_ule:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __gtdf2@plt
; RV32I-NEXT:    slti a0, a0, 1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_ule:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gtdf2@plt
; RV64I-NEXT:    slti a0, a0, 1
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ule double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_une(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_une:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    feq.d a0, fa0, fa1
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_une:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    feq.d a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_une:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __nedf2@plt
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_une:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __nedf2@plt
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp une double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_uno(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_uno:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    feq.d a0, fa1, fa1
; CHECKIFD-NEXT:    feq.d a1, fa0, fa0
; CHECKIFD-NEXT:    and a0, a1, a0
; CHECKIFD-NEXT:    xori a0, a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_uno:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    feq.d a1, a1, a1
; CHECKIZFINXZDINX-NEXT:    feq.d a0, a0, a0
; CHECKIZFINXZDINX-NEXT:    and a0, a0, a1
; CHECKIZFINXZDINX-NEXT:    xori a0, a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_uno:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __unorddf2@plt
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_uno:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __unorddf2@plt
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp uno double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_true(double %a, double %b) nounwind {
; CHECKIFD-LABEL: fcmp_true:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    li a0, 1
; CHECKIFD-NEXT:    ret
;
; CHECKIZFINXZDINX-LABEL: fcmp_true:
; CHECKIZFINXZDINX:       # %bb.0:
; CHECKIZFINXZDINX-NEXT:    li a0, 1
; CHECKIZFINXZDINX-NEXT:    ret
;
; RV32I-LABEL: fcmp_true:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcmp_true:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 1
; RV64I-NEXT:    ret
  %1 = fcmp true double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}