! This test checks lowering of OpenACC data directive.

! RUN: bbc -fopenacc -emit-fir %s -o - | FileCheck %s

subroutine acc_data
  real, dimension(10, 10) :: a, b, c
  real, pointer :: d, e
  logical :: ifCondition = .TRUE.

! CHECK: %[[A:.*]] = fir.alloca !fir.array<10x10xf32> {{{.*}}uniq_name = "{{.*}}Ea"}
! CHECK: %[[B:.*]] = fir.alloca !fir.array<10x10xf32> {{{.*}}uniq_name = "{{.*}}Eb"}
! CHECK: %[[C:.*]] = fir.alloca !fir.array<10x10xf32> {{{.*}}uniq_name = "{{.*}}Ec"}
! CHECK: %[[D:.*]] = fir.alloca !fir.box<!fir.ptr<f32>> {bindc_name = "d", uniq_name = "{{.*}}Ed"}
! CHECK: %[[E:.*]] = fir.alloca !fir.box<!fir.ptr<f32>> {bindc_name = "e", uniq_name = "{{.*}}Ee"}

  !$acc data if(.TRUE.) copy(a)
  !$acc end data

! CHECK:      %[[IF1:.*]] = arith.constant true
! CHECK:      %[[COPYIN:.*]] = acc.copyin varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "a"}
! CHECK:      acc.data if(%[[IF1]]) dataOperands(%[[COPYIN]] : !fir.ref<!fir.array<10x10xf32>>)  {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.copyout accPtr(%[[COPYIN]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "a"}

  !$acc data copy(a) if(ifCondition)
  !$acc end data

! CHECK:      %[[COPYIN:.*]] = acc.copyin varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "a"}
! CHECK:      %[[IFCOND:.*]] = fir.load %{{.*}} : !fir.ref<!fir.logical<4>>
! CHECK:      %[[IF2:.*]] = fir.convert %[[IFCOND]] : (!fir.logical<4>) -> i1
! CHECK:      acc.data if(%[[IF2]]) dataOperands(%[[COPYIN]] : !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.copyout accPtr(%[[COPYIN]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "a"}

  !$acc data copy(a, b, c)
  !$acc end data

! CHECK:      %[[COPYIN_A:.*]] = acc.copyin varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "a"}
! CHECK:      %[[COPYIN_B:.*]] = acc.copyin varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "b"}
! CHECK:      %[[COPYIN_C:.*]] = acc.copyin varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[COPYIN_A]], %[[COPYIN_B]], %[[COPYIN_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.copyout accPtr(%[[COPYIN_A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "a"}
! CHECK: acc.copyout accPtr(%[[COPYIN_B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "b"}
! CHECK: acc.copyout accPtr(%[[COPYIN_C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "c"}

  !$acc data copy(a) copy(b) copy(c)
  !$acc end data

! CHECK:      %[[COPYIN_A:.*]] = acc.copyin varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "a"}
! CHECK:      %[[COPYIN_B:.*]] = acc.copyin varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "b"}
! CHECK:      %[[COPYIN_C:.*]] = acc.copyin varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 3 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[COPYIN_A]], %[[COPYIN_B]], %[[COPYIN_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.copyout accPtr(%[[COPYIN_A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "a"}
! CHECK: acc.copyout accPtr(%[[COPYIN_B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "b"}
! CHECK: acc.copyout accPtr(%[[COPYIN_C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 3 : i64, name = "c"}

  !$acc data copyin(a) copyin(readonly: b, c)
  !$acc end data

! CHECK:      %[[COPYIN_A:.*]] = acc.copyin varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "a"}
! CHECK:      %[[COPYIN_B:.*]] = acc.copyin varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 2 : i64, name = "b"}
! CHECK:      %[[COPYIN_C:.*]] = acc.copyin varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 2 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[COPYIN_A]], %[[COPYIN_B]], %[[COPYIN_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}

  !$acc data copyout(a) copyout(zero: b) copyout(c)
  !$acc end data

! CHECK:      %[[CREATE_A:.*]] = acc.create varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 4 : i64, name = "a"}
! CHECK:      %[[CREATE_B:.*]] = acc.create varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 5 : i64, name = "b"}
! CHECK:      %[[CREATE_C:.*]] = acc.create varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 4 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[CREATE_A]], %[[CREATE_B]], %[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.copyout accPtr(%[[CREATE_A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) {name = "a"}
! CHECK: acc.copyout accPtr(%[[CREATE_B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) {dataClause = 5 : i64, name = "b"}
! CHECK: acc.copyout accPtr(%[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) to varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) {name = "c"}

  !$acc data create(a, b) create(zero: c)
  !$acc end data

! CHECK:      %[[CREATE_A:.*]] = acc.create varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "a"}
! CHECK:      %[[CREATE_B:.*]] = acc.create varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "b"}
! CHECK:      %[[CREATE_C:.*]] = acc.create varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 8 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[CREATE_A]], %[[CREATE_B]], %[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.delete accPtr(%[[CREATE_A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) {dataClause = 7 : i64, name = "a"}
! CHECK: acc.delete accPtr(%[[CREATE_B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) {dataClause = 7 : i64, name = "b"}
! CHECK: acc.delete accPtr(%[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) {dataClause = 8 : i64, name = "c"}


  !$acc data no_create(a, b) create(zero: c)
  !$acc end data

! CHECK:      %[[NO_CREATE_A:.*]] = acc.nocreate varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "a"}
! CHECK:      %[[NO_CREATE_B:.*]] = acc.nocreate varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "b"}
! CHECK:      %[[CREATE_C:.*]] = acc.create varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {dataClause = 8 : i64, name = "c"}
! CHECK:      acc.data dataOperands(%[[NO_CREATE_A]], %[[NO_CREATE_B]], %[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.delete accPtr(%[[CREATE_C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) {dataClause = 8 : i64, name = "c"}

  !$acc data present(a, b, c)
  !$acc end data

! CHECK:      %[[PRESENT_A:.*]] = acc.present varPtr(%[[A]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "a"}
! CHECK:      %[[PRESENT_B:.*]] = acc.present varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "b"}
! CHECK:      %[[PRESENT_C:.*]] = acc.present varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "c"}
! CHECK:      acc.data dataOperands(%[[PRESENT_A]], %[[PRESENT_B]], %[[PRESENT_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}

  !$acc data deviceptr(b, c)
  !$acc end data

! CHECK:      %[[DEVICEPTR_B:.*]] = acc.deviceptr varPtr(%[[B]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "b"} 
! CHECK:      %[[DEVICEPTR_C:.*]] = acc.deviceptr varPtr(%[[C]] : !fir.ref<!fir.array<10x10xf32>>) bounds(%{{.*}}, %{{.*}}) -> !fir.ref<!fir.array<10x10xf32>> {name = "c"} 
! CHECK:      acc.data dataOperands(%[[DEVICEPTR_B]], %[[DEVICEPTR_C]] : !fir.ref<!fir.array<10x10xf32>>, !fir.ref<!fir.array<10x10xf32>>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}

  !$acc data attach(d, e)
  !$acc end data

! CHECK:      %[[ATTACH_D:.*]] = acc.attach varPtr(%{{.*}} : !fir.ptr<f32>) -> !fir.ptr<f32> {name = "d"}
! CHECK:      %[[ATTACH_E:.*]] = acc.attach varPtr(%{{.*}} : !fir.ptr<f32>) -> !fir.ptr<f32> {name = "e"}
! CHECK:      acc.data dataOperands(%[[ATTACH_D]], %[[ATTACH_E]] : !fir.ptr<f32>, !fir.ptr<f32>) {
! CHECK:        acc.terminator
! CHECK-NEXT: }{{$}}
! CHECK: acc.detach accPtr(%[[ATTACH_D]] : !fir.ptr<f32>) {dataClause = 10 : i64, name = "d"}
! CHECK: acc.detach accPtr(%[[ATTACH_E]] : !fir.ptr<f32>) {dataClause = 10 : i64, name = "e"}

end subroutine acc_data
