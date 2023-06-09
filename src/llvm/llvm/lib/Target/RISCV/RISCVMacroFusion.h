//===- RISCVMacroFusion.h - RISC-V Macro Fusion -----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
/// \file This file contains the RISC-V definition of the DAG scheduling
/// mutation to pair instructions back to back.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_RISCV_RISCVMACROFUSION_H
#define LLVM_LIB_TARGET_RISCV_RISCVMACROFUSION_H

#include "llvm/CodeGen/MachineScheduler.h"

namespace llvm {

/// Note that you have to add:
///   DAG.addMutation(createRISCVMacroFusionDAGMutation());
/// to RISCVPassConfig::createMachineScheduler() to have an effect.
std::unique_ptr<ScheduleDAGMutation> createRISCVMacroFusionDAGMutation();

} // namespace llvm

#endif
