; RUN: llc < %s | FileCheck %s

target datalayout = "e-m:e-p:16:16-i32:16:32-a:16-n8:16"
target triple = "msp430---elf"

define void @test_no_clobber() {
entry:
; CHECK-LABEL: test_no_clobber
; CHECK-NOT: push
  call void asm sideeffect "", ""()
; CHECK-NOT: pop
  ret void
; CHECK: -- End function
}

define void @test_1() {
entry:
; CHECK-LABEL: test_1:
; CHECK: push r4
; CHECK: .cfi_def_cfa_offset 4
; CHECK: push r6
; CHECK: .cfi_def_cfa_offset 6
; CHECK: push r8
; CHECK: .cfi_def_cfa_offset 8
; CHECK: .cfi_offset r4, -4
; CHECK: .cfi_offset r6, -6
; CHECK: .cfi_offset r8, -8
  call void asm sideeffect "", "~{r4},~{r6},~{r8}"()
; CHECK: pop r8
; CHECK: .cfi_def_cfa_offset 6
; CHECK: pop r6
; CHECK: .cfi_def_cfa_offset 4
; CHECK: pop r4
; CHECK: .cfi_def_cfa_offset 2
; CHECK: .cfi_restore r4
; CHECK: .cfi_restore r6
; CHECK: .cfi_restore r8
  ret void
}

define void @test_2() {
entry:
; CHECK-LABEL: test_2:
; CHECK: push  r5
; CHECK: .cfi_def_cfa_offset 4
; CHECK: push  r7
; CHECK: .cfi_def_cfa_offset 6
; CHECK: push  r9
; CHECK: .cfi_def_cfa_offset 8
; CHECK: .cfi_offset r5, -4
; CHECK: .cfi_offset r7, -6
; CHECK: .cfi_offset r9, -8
  call void asm sideeffect "", "~{r5},~{r7},~{r9}"()
; CHECK: pop r9
; CHECK: .cfi_def_cfa_offset 6
; CHECK: pop r7
; CHECK: .cfi_def_cfa_offset 4
; CHECK: pop r5
; CHECK: .cfi_def_cfa_offset 2
; CHECK: .cfi_restore r5
; CHECK: .cfi_restore r7
; CHECK: .cfi_restore r9
  ret void
}

; The r10 register is special because the sequence
;   pop r10
;   ret
; can be replaced with
;   jmp __mspabi_func_epilog_1
; or other such function (depending on previous instructions).
; Still, it is not replaced *yet*.
define void @test_r10() {
entry:
; CHECK-LABEL: test_r10:
; CHECK: push r10
; CHECK: .cfi_def_cfa_offset 4
; CHECK: .cfi_offset r10, -4
  call void asm sideeffect "", "~{r10}"()
; CHECK: pop r10
; CHECK: .cfi_def_cfa_offset 2
; CHECK: .cfi_restore r10
  ret void
}
