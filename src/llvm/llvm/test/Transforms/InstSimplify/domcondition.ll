; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

define i32 @xor_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @xor_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %xor = xor i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %xor, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @sub_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %sub = sub i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %sub, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @udiv_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @udiv_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ 1, [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %udiv = udiv i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %udiv, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @sdiv_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @sdiv_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ 1, [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %sdiv = sdiv i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %sdiv, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @urem_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @urem_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %urem = urem i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %urem, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @srem_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @srem_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %srem = srem i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %srem, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

; TODO: %and can be one of %x, %y
define i32 @and_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @and_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[Y]], [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %and = and i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %and, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

; TODO: %or can be one of %x, %y
define i32 @or_domcondition(i32 %x, i32 %y) {
; CHECK-LABEL: @or_domcondition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[Y]], [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %or = or i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %or, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

; negative test, dominate condtion is not eq
define i32 @xor_domcondition_negative(i32 %x, i32 %y) {
; CHECK-LABEL: @xor_domcondition_negative(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[XOR]], [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp uge i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  %xor = xor i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %xor, %cond.true ], [ 0, %entry ]
  ret i32 %cond
}

define i32 @xor_simplify_by_dci(i32 %x, i32 %y, i1 %c) {
; CHECK-LABEL: @xor_simplify_by_dci(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[XORBB:%.*]], label [[COND_END]]
; CHECK:       xorbb:
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[XOR]], [[XORBB]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[COND_TRUE]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:
  br i1 %c, label %xorbb, label %cond.end

xorbb:
  %xor = xor i32 %x, %y
  br label %cond.end

cond.end:
  %cond = phi i32 [ %xor, %xorbb ], [ 0, %entry ], [0, %cond.true]
  ret i32 %cond
}

define void @icmp_simplify_by_dci(i32 %a, i32 %b, i1 %x) {
; CHECK-LABEL: @icmp_simplify_by_dci(
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[END:%.*]], label [[TAKEN:%.*]]
; CHECK:       taken:
; CHECK-NEXT:    br i1 [[X:%.*]], label [[SELBB:%.*]], label [[END]]
; CHECK:       selbb:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ne i32 [[A]], [[B]]
; CHECK-NEXT:    [[C:%.*]] = select i1 [[CMP2]], i32 20, i32 0
; CHECK-NEXT:    call void @foo(i32 [[C]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp1 = icmp eq i32 %a, %b
  br i1 %cmp1, label %end, label %taken

taken:
  br i1 %x, label %selbb, label %end

selbb:
  %cmp2 = icmp ne i32 %a, %b
  %c = select i1 %cmp2, i32 20, i32 0
  call void @foo(i32 %c)
  br label %end

end:
  ret void
}

declare void @foo(i32)
