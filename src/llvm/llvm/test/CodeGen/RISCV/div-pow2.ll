; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV64I

define i32 @sdiv32_pow2_2(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a1, a0, 31
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srliw a1, a0, 31
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 1
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, 2
  ret i32 %div
}

define i32 @sdiv32_pow2_negative_2(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_negative_2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a1, a0, 31
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 1
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_negative_2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srliw a1, a0, 31
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 1
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, -2
  ret i32 %div
}

define i32 @sdiv32_pow2_2048(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_2048:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 21
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 11
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_2048:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 21
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 11
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, 2048
  ret i32 %div
}

define i32 @sdiv32_pow2_negative_2048(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_negative_2048:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 21
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 11
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_negative_2048:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 21
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 11
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, -2048
  ret i32 %div
}

define i32 @sdiv32_pow2_4096(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_4096:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 20
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 12
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_4096:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 20
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 12
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, 4096
  ret i32 %div
}

define i32 @sdiv32_pow2_negative_4096(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_negative_4096:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 20
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 12
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_negative_4096:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 20
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 12
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, -4096
  ret i32 %div
}

define i32 @sdiv32_pow2_65536(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_65536:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_65536:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 16
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 16
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, 65536
  ret i32 %div
}

define i32 @sdiv32_pow2_negative_65536(i32 %a) {
; RV32I-LABEL: sdiv32_pow2_negative_65536:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv32_pow2_negative_65536:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 16
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 16
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i32 %a, -65536
  ret i32 %div
}

define i64 @sdiv64_pow2_2(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a2, a1, 31
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 1
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 31
; RV32I-NEXT:    or a0, a3, a0
; RV32I-NEXT:    srai a1, a1, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srli a1, a0, 63
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 1
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, 2
  ret i64 %div
}

define i64 @sdiv64_pow2_negative_2(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_negative_2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a2, a1, 31
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 1
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 31
; RV32I-NEXT:    or a3, a3, a0
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a2, a3
; RV32I-NEXT:    srai a1, a1, 1
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_negative_2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srli a1, a0, 63
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 1
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, -2
  ret i64 %div
}

define i64 @sdiv64_pow2_2048(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_2048:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 21
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 11
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 21
; RV32I-NEXT:    or a0, a3, a0
; RV32I-NEXT:    srai a1, a1, 11
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_2048:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 53
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 11
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, 2048
  ret i64 %div
}

define i64 @sdiv64_pow2_negative_2048(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_negative_2048:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 21
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 11
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 21
; RV32I-NEXT:    or a3, a3, a0
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a2, a3
; RV32I-NEXT:    srai a1, a1, 11
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_negative_2048:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 53
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 11
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, -2048
  ret i64 %div
}

define i64 @sdiv64_pow2_4096(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_4096:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 20
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 12
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 20
; RV32I-NEXT:    or a0, a3, a0
; RV32I-NEXT:    srai a1, a1, 12
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_4096:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 52
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 12
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, 4096
  ret i64 %div
}

define i64 @sdiv64_pow2_negative_4096(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_negative_4096:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 20
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 12
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 20
; RV32I-NEXT:    or a3, a3, a0
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a2, a3
; RV32I-NEXT:    srai a1, a1, 12
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_negative_4096:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 52
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 12
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, -4096
  ret i64 %div
}

define i64 @sdiv64_pow2_65536(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_65536:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 16
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 16
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 16
; RV32I-NEXT:    or a0, a3, a0
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_65536:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 48
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 16
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, 65536
  ret i64 %div
}

define i64 @sdiv64_pow2_negative_65536(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_negative_65536:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    srli a2, a2, 16
; RV32I-NEXT:    add a2, a0, a2
; RV32I-NEXT:    srli a3, a2, 16
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a1, a1, a0
; RV32I-NEXT:    slli a0, a1, 16
; RV32I-NEXT:    or a3, a3, a0
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a2, a3
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_negative_65536:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 48
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 16
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, -65536
  ret i64 %div
}

define i64 @sdiv64_pow2_8589934592(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_8589934592:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a2, a1, 31
; RV32I-NEXT:    add a2, a1, a2
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    add a1, a0, a1
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    add a1, a2, a0
; RV32I-NEXT:    srai a0, a1, 1
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_8589934592:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 31
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 33
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, 8589934592 ; 2^33
  ret i64 %div
}

define i64 @sdiv64_pow2_negative_8589934592(i64 %a) {
; RV32I-LABEL: sdiv64_pow2_negative_8589934592:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    srli a2, a1, 31
; RV32I-NEXT:    add a2, a1, a2
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    add a1, a0, a1
; RV32I-NEXT:    sltu a0, a1, a0
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srai a0, a0, 1
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sdiv64_pow2_negative_8589934592:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    srli a1, a1, 31
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srai a0, a0, 33
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    ret
entry:
  %div = sdiv i64 %a, -8589934592 ; -2^33
  ret i64 %div
}