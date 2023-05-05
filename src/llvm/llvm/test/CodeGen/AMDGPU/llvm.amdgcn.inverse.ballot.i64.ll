; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=amdgcn -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -mattr=-wavefrontsize32,+wavefrontsize64 -global-isel=1 -verify-machineinstrs < %s | FileCheck -check-prefixes=GISEL %s
; RUN: llc -march=amdgcn -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -mattr=-wavefrontsize32,+wavefrontsize64 -global-isel=0 -verify-machineinstrs < %s | FileCheck -check-prefixes=SDAG %s

declare i1 @llvm.amdgcn.inverse.ballot.i64(i64)

; Test ballot(0)
define amdgpu_cs void @constant_false_inverse_ballot(ptr addrspace(1) %out) {
; GISEL-LABEL: constant_false_inverse_ballot:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_mov_b64 s[0:1], 0
; GISEL-NEXT:    v_mov_b32_e32 v3, 0
; GISEL-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: constant_false_inverse_ballot:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_mov_b32 s2, 0
; SDAG-NEXT:    s_mov_b64 s[0:1], 0
; SDAG-NEXT:    v_mov_b32_e32 v3, s2
; SDAG-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 0)
  %sel    = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

; Test ballot(1)

define amdgpu_cs void @constant_true_inverse_ballot(ptr addrspace(1) %out) {
; GISEL-LABEL: constant_true_inverse_ballot:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_mov_b64 s[0:1], -1
; GISEL-NEXT:    v_mov_b32_e32 v3, 0
; GISEL-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: constant_true_inverse_ballot:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_mov_b32 s2, 0
; SDAG-NEXT:    s_mov_b64 s[0:1], -1
; SDAG-NEXT:    v_mov_b32_e32 v3, s2
; SDAG-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 u0xFFFFFFFFFFFFFFFF)
  %sel    = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

; Test ballot(u0x0040F8010000)

define amdgpu_cs void @constant_mask_inverse_ballot(ptr addrspace(1) %out) {
; GISEL-LABEL: constant_mask_inverse_ballot:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_mov_b32 s0, 0xf8010000
; GISEL-NEXT:    s_mov_b32 s1, 64
; GISEL-NEXT:    v_mov_b32_e32 v3, 0
; GISEL-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: constant_mask_inverse_ballot:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_mov_b32 s0, 0xf8010000
; SDAG-NEXT:    s_mov_b32 s2, 0
; SDAG-NEXT:    s_mov_b32 s1, 64
; SDAG-NEXT:    v_mov_b32_e32 v3, s2
; SDAG-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 u0x0040F8010000)
  %sel    = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

; Test inverse ballot using a vgpr as input

define amdgpu_cs void @vgpr_inverse_ballot(i64 %input, ptr addrspace(1) %out) {
; GISEL-LABEL: vgpr_inverse_ballot:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    v_readfirstlane_b32 s0, v0
; GISEL-NEXT:    v_readfirstlane_b32 s1, v1
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[0:1]
; GISEL-NEXT:    global_store_b64 v[2:3], v[0:1], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: vgpr_inverse_ballot:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    v_readfirstlane_b32 s0, v0
; SDAG-NEXT:    v_readfirstlane_b32 s1, v1
; SDAG-NEXT:    s_mov_b32 s2, 0
; SDAG-NEXT:    v_mov_b32_e32 v1, s2
; SDAG-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[0:1]
; SDAG-NEXT:    global_store_b64 v[2:3], v[0:1], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 %input)
  %sel    = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

define amdgpu_cs void @sgpr_inverse_ballot(i64 inreg %input, ptr addrspace(1) %out) {
; GISEL-LABEL: sgpr_inverse_ballot:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; GISEL-NEXT:    v_mov_b32_e32 v3, 0
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: sgpr_inverse_ballot:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; SDAG-NEXT:    s_mov_b32 s0, 0
; SDAG-NEXT:    s_waitcnt_depctr 0xfffe
; SDAG-NEXT:    v_mov_b32_e32 v3, s0
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 %input)
  %sel = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

; Test ballot after phi
define amdgpu_cs void @phi_uniform(i64 inreg %s0_1, i64 inreg %s2, ptr addrspace(1) %out) {
; GISEL-LABEL: phi_uniform:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_cmp_lg_u64 s[2:3], 0
; GISEL-NEXT:    s_cbranch_scc1 .LBB5_2
; GISEL-NEXT:  ; %bb.1: ; %if
; GISEL-NEXT:    s_add_u32 s0, s0, 1
; GISEL-NEXT:    s_addc_u32 s1, s1, 0
; GISEL-NEXT:  .LBB5_2: ; %endif
; GISEL-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; GISEL-NEXT:    v_mov_b32_e32 v3, 0
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: phi_uniform:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_cmp_lg_u64 s[2:3], 0
; SDAG-NEXT:    s_cbranch_scc1 .LBB5_2
; SDAG-NEXT:  ; %bb.1: ; %if
; SDAG-NEXT:    s_add_u32 s0, s0, 1
; SDAG-NEXT:    s_addc_u32 s1, s1, 0
; SDAG-NEXT:  .LBB5_2: ; %endif
; SDAG-NEXT:    s_mov_b32 s2, 0
; SDAG-NEXT:    v_cndmask_b32_e64 v2, 0, 1, s[0:1]
; SDAG-NEXT:    v_mov_b32_e32 v3, s2
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %cc = icmp ne i64 %s2, 0
  br i1 %cc, label %endif, label %if

if:
  %tmp = add  i64 %s0_1, 1
  br label %endif

endif:
  %input = phi i64 [ %s0_1, %entry ], [ %tmp, %if ]

  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 %input)
  %sel = select i1 %ballot, i64 1, i64 0
  store i64 %sel, ptr addrspace(1) %out
  ret void
}

; Test for branching
; GISel implementation is currently incorrect.
; The change in the branch affects all lanes, not just the branching ones.
; This test will be fixed once GISel correctly takes uniformity analysis into account.
define amdgpu_cs void @inverse_ballot_branch(i64 inreg %s0_1, i64 inreg %s2, ptr addrspace(1) %out) {
; GISEL-LABEL: inverse_ballot_branch:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_xor_b64 s[4:5], s[2:3], -1
; GISEL-NEXT:    s_and_saveexec_b64 s[2:3], s[4:5]
; GISEL-NEXT:  ; %bb.1: ; %if
; GISEL-NEXT:    s_add_u32 s0, s0, 1
; GISEL-NEXT:    s_addc_u32 s1, s1, 0
; GISEL-NEXT:  ; %bb.2: ; %endif
; GISEL-NEXT:    s_or_b64 exec, exec, s[2:3]
; GISEL-NEXT:    v_mov_b32_e32 v3, s1
; GISEL-NEXT:    v_mov_b32_e32 v2, s0
; GISEL-NEXT:    global_store_b64 v[0:1], v[2:3], off
; GISEL-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GISEL-NEXT:    s_endpgm
;
; SDAG-LABEL: inverse_ballot_branch:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    v_mov_b32_e32 v3, s1
; SDAG-NEXT:    v_mov_b32_e32 v2, s0
; SDAG-NEXT:    s_xor_b64 s[4:5], s[2:3], -1
; SDAG-NEXT:    s_and_saveexec_b64 s[2:3], s[4:5]
; SDAG-NEXT:  ; %bb.1: ; %if
; SDAG-NEXT:    s_add_u32 s0, s0, 1
; SDAG-NEXT:    s_addc_u32 s1, s1, 0
; SDAG-NEXT:    v_mov_b32_e32 v3, s1
; SDAG-NEXT:    v_mov_b32_e32 v2, s0
; SDAG-NEXT:  ; %bb.2: ; %endif
; SDAG-NEXT:    s_or_b64 exec, exec, s[2:3]
; SDAG-NEXT:    global_store_b64 v[0:1], v[2:3], off
; SDAG-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; SDAG-NEXT:    s_endpgm
entry:
  %ballot = call i1 @llvm.amdgcn.inverse.ballot.i64(i64 %s2)
  br i1 %ballot, label %endif, label %if

if:
  %tmp = add  i64 %s0_1, 1
  br label %endif

endif:
  %sel = phi i64 [ %s0_1, %entry ], [ %tmp, %if ]
  store i64 %sel, ptr addrspace(1) %out
  ret void
}