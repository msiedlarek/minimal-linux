; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='sroa' -S < %s | FileCheck %s

define target("aarch64.svcount") @test_alloca_store_reload(target("aarch64.svcount") %val) nounwind {
; CHECK-LABEL: @test_alloca_store_reload(
; CHECK-NEXT:    ret target("aarch64.svcount") [[VAL:%.*]]
;
  %ptr = alloca target("aarch64.svcount"), align 1
  store target("aarch64.svcount") %val, ptr %ptr
  %res = load target("aarch64.svcount"), ptr %ptr
  ret target("aarch64.svcount") %res
}
