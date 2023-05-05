; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S < %s -mtriple=x86_64-unknown-linux -slp-threshold=-107 | FileCheck %s

define void @test(i64 %p0, i64 %p1, i64 %p2, i64 %p3) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x i64> poison, i64 [[P0:%.*]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x i64> [[TMP0]], i64 [[P1:%.*]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = add <2 x i64> [[TMP1]], [[TMP1]]
; CHECK-NEXT:    [[A2:%.*]] = add i64 [[P2:%.*]], [[P2]]
; CHECK-NEXT:    [[A3:%.*]] = add i64 [[P3:%.*]], [[P3]]
; CHECK-NEXT:    [[TMP3:%.*]] = mul <2 x i64> [[TMP1]], [[TMP1]]
; CHECK-NEXT:    [[M2:%.*]] = mul i64 [[P2]], [[P2]]
; CHECK-NEXT:    [[M3:%.*]] = mul i64 [[P3]], [[P3]]
; CHECK-NEXT:    [[TMP4:%.*]] = sdiv <2 x i64> [[TMP1]], [[TMP1]]
; CHECK-NEXT:    [[D2:%.*]] = sdiv i64 [[P2]], [[P2]]
; CHECK-NEXT:    [[D3:%.*]] = sdiv i64 [[P3]], [[P3]]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <2 x i64> [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x i64> [[TMP3]], i32 0
; CHECK-NEXT:    [[S0:%.*]] = sub i64 [[TMP6]], [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x i64> [[TMP4]], i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x i64> [[TMP3]], i32 1
; CHECK-NEXT:    [[S1:%.*]] = sub i64 [[TMP8]], [[TMP7]]
; CHECK-NEXT:    [[S2:%.*]] = sub i64 [[M2]], [[D2]]
; CHECK-NEXT:    [[S3:%.*]] = sub i64 [[M3]], [[D3]]
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <2 x i64> [[TMP2]], i32 0
; CHECK-NEXT:    [[SHL1:%.*]] = shl i64 [[TMP9]], [[S0]]
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x i64> [[TMP2]], i32 1
; CHECK-NEXT:    [[SHL2:%.*]] = shl i64 [[TMP10]], [[S1]]
; CHECK-NEXT:    [[SHL3:%.*]] = shl i64 [[A2]], [[S2]]
; CHECK-NEXT:    [[SHL4:%.*]] = shl i64 [[A3]], [[S3]]
; CHECK-NEXT:    [[O0:%.*]] = or i64 [[TMP9]], [[TMP10]]
; CHECK-NEXT:    [[TT0:%.*]] = trunc i64 [[O0]] to i32
; CHECK-NEXT:    [[O1:%.*]] = or i64 [[TMP6]], [[TMP8]]
; CHECK-NEXT:    [[TT1:%.*]] = trunc i64 [[O1]] to i32
; CHECK-NEXT:    [[O2:%.*]] = or i64 [[TMP5]], [[TMP7]]
; CHECK-NEXT:    [[TT2:%.*]] = trunc i64 [[O2]] to i32
; CHECK-NEXT:    [[O3:%.*]] = or i64 [[TMP6]], [[TMP8]]
; CHECK-NEXT:    [[TT3:%.*]] = trunc i64 [[O3]] to i32
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[PHI0:%.*]] = phi i32 [ [[T1:%.*]], [[BB]] ], [ [[TT0]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[PHI1:%.*]] = phi i32 [ [[T2:%.*]], [[BB]] ], [ [[TT1]], [[ENTRY]] ]
; CHECK-NEXT:    [[PHI2:%.*]] = phi i32 [ [[T3:%.*]], [[BB]] ], [ [[TT2]], [[ENTRY]] ]
; CHECK-NEXT:    [[PHI3:%.*]] = phi i32 [ [[T4:%.*]], [[BB]] ], [ [[TT3]], [[ENTRY]] ]
; CHECK-NEXT:    [[T1]] = trunc i64 [[SHL1]] to i32
; CHECK-NEXT:    [[T2]] = trunc i64 [[SHL2]] to i32
; CHECK-NEXT:    [[T3]] = trunc i64 [[SHL3]] to i32
; CHECK-NEXT:    [[T4]] = trunc i64 [[SHL4]] to i32
; CHECK-NEXT:    br label [[BB]]
;
entry:
  %a0 = add i64 %p0, %p0
  %a1 = add i64 %p1, %p1
  %a2 = add i64 %p2, %p2
  %a3 = add i64 %p3, %p3
  %m0 = mul i64 %p0, %p0
  %m1 = mul i64 %p1, %p1
  %m2 = mul i64 %p2, %p2
  %m3 = mul i64 %p3, %p3
  %d0 = sdiv i64 %p0, %p0
  %d1 = sdiv i64 %p1, %p1
  %d2 = sdiv i64 %p2, %p2
  %d3 = sdiv i64 %p3, %p3
  %s0 = sub i64 %m0, %d0
  %s1 = sub i64 %m1, %d1
  %s2 = sub i64 %m2, %d2
  %s3 = sub i64 %m3, %d3
  %shl1 = shl i64 %a0, %s0
  %shl2 = shl i64 %a1, %s1
  %shl3 = shl i64 %a2, %s2
  %shl4 = shl i64 %a3, %s3
  %o0 = or i64 %a0, %a1
  %tt0 = trunc i64 %o0 to i32
  %o1 = or i64 %m0, %m1
  %tt1 = trunc i64 %o1 to i32
  %o2 = or i64 %d0, %d1
  %tt2 = trunc i64 %o2 to i32
  %o3 = or i64 %m0, %m1
  %tt3 = trunc i64 %o3 to i32
  br label %bb

bb:
  %phi0 = phi i32 [ %t1, %bb ], [ %tt0, %entry ]
  %phi1 = phi i32 [ %t2, %bb ], [ %tt1, %entry ]
  %phi2 = phi i32 [ %t3, %bb ], [ %tt2, %entry ]
  %phi3 = phi i32 [ %t4, %bb ], [ %tt3, %entry ]
  %t1 = trunc i64 %shl1 to i32
  %t2 = trunc i64 %shl2 to i32
  %t3 = trunc i64 %shl3 to i32
  %t4 = trunc i64 %shl4 to i32
  br label %bb
}