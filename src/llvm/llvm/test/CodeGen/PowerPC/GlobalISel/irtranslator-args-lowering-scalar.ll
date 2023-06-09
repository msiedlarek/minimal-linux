; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu -global-isel \
; RUN:     -verify-machineinstrs -stop-after=irtranslator < %s | FileCheck %s

; Pass up to eight integer arguments in registers.
define void @test_scalar1(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e, i32 %f, i32 %g, i32 %h) {
  ; CHECK-LABEL: name: test_scalar1
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s32) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s32) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC3:%[0-9]+]]:_(s32) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC4:%[0-9]+]]:_(s32) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[TRUNC5:%[0-9]+]]:_(s32) = G_TRUNC [[COPY5]](s64)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC6:%[0-9]+]]:_(s32) = G_TRUNC [[COPY6]](s64)
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   [[TRUNC7:%[0-9]+]]:_(s32) = G_TRUNC [[COPY7]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_scalar2(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e, i64 %f, i64 %g, i64 %h) {
  ; CHECK-LABEL: name: test_scalar2
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_scalar3(i8 %a, i8 %b, i8 %c, i8 %d, i8 %e, i8 %f, i8 %g, i8 %h) {
  ; CHECK-LABEL: name: test_scalar3
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s8) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s8) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC3:%[0-9]+]]:_(s8) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC4:%[0-9]+]]:_(s8) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[TRUNC5:%[0-9]+]]:_(s8) = G_TRUNC [[COPY5]](s64)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC6:%[0-9]+]]:_(s8) = G_TRUNC [[COPY6]](s64)
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   [[TRUNC7:%[0-9]+]]:_(s8) = G_TRUNC [[COPY7]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_scalar4(i16 %a, i16 %b, i16 %c, i16 %d, i16 %e, i16 %f, i16 %g, i16 %h) {
  ; CHECK-LABEL: name: test_scalar4
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s16) = G_TRUNC [[COPY]](s64)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[TRUNC1:%[0-9]+]]:_(s16) = G_TRUNC [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[TRUNC2:%[0-9]+]]:_(s16) = G_TRUNC [[COPY2]](s64)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[TRUNC3:%[0-9]+]]:_(s16) = G_TRUNC [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[TRUNC4:%[0-9]+]]:_(s16) = G_TRUNC [[COPY4]](s64)
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[TRUNC5:%[0-9]+]]:_(s16) = G_TRUNC [[COPY5]](s64)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[TRUNC6:%[0-9]+]]:_(s16) = G_TRUNC [[COPY6]](s64)
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   [[TRUNC7:%[0-9]+]]:_(s16) = G_TRUNC [[COPY7]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_scalar5(i128 %a, i128 %b, i128 %c, i128 %d) {
  ; CHECK-LABEL: name: test_scalar5
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY]](s64), [[COPY1]](s64)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK-NEXT:   [[MV1:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY2]](s64), [[COPY3]](s64)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x8
  ; CHECK-NEXT:   [[MV2:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY4]](s64), [[COPY5]](s64)
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x9
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x10
  ; CHECK-NEXT:   [[MV3:%[0-9]+]]:_(s128) = G_MERGE_VALUES [[COPY6]](s64), [[COPY7]](s64)
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

; Pass up to thirteen fp arguments in registers.
define void @test_scalar6(float %a, float %b, float %c, float %d, float %e, float %f, float %g, float %h, float %i, float %j, float %k, float %l, float %m) {
  ; CHECK-LABEL: name: test_scalar6
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $f10, $f11, $f12, $f13
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $f3
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $f4
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s32) = COPY $f5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s32) = COPY $f6
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s32) = COPY $f7
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s32) = COPY $f8
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(s32) = COPY $f9
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(s32) = COPY $f10
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(s32) = COPY $f11
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s32) = COPY $f12
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(s32) = COPY $f13
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

define void @test_scalar7(double %a, double %b, double %c, double %d, double %e, double %f, double %g, double %h, double %i, double %j, double %k, double %l, double %m) {
  ; CHECK-LABEL: name: test_scalar7
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   liveins: $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $f10, $f11, $f12, $f13
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $f1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $f2
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $f3
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $f4
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:_(s64) = COPY $f5
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:_(s64) = COPY $f6
  ; CHECK-NEXT:   [[COPY6:%[0-9]+]]:_(s64) = COPY $f7
  ; CHECK-NEXT:   [[COPY7:%[0-9]+]]:_(s64) = COPY $f8
  ; CHECK-NEXT:   [[COPY8:%[0-9]+]]:_(s64) = COPY $f9
  ; CHECK-NEXT:   [[COPY9:%[0-9]+]]:_(s64) = COPY $f10
  ; CHECK-NEXT:   [[COPY10:%[0-9]+]]:_(s64) = COPY $f11
  ; CHECK-NEXT:   [[COPY11:%[0-9]+]]:_(s64) = COPY $f12
  ; CHECK-NEXT:   [[COPY12:%[0-9]+]]:_(s64) = COPY $f13
  ; CHECK-NEXT:   BLR8 implicit $lr8, implicit $rm
entry:
  ret void
}

