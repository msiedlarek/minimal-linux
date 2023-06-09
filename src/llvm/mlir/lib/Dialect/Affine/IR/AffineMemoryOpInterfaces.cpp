//===- AffineMemoryOpInterfaces.cpp ---------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/Affine/IR/AffineMemoryOpInterfaces.h"

using namespace mlir;
using namespace mlir::affine;

//===----------------------------------------------------------------------===//
// Affine Memory Op Interfaces
//===----------------------------------------------------------------------===//

/// Include the definitions of the affine memory op interfaces.
#include "mlir/Dialect/Affine/IR/AffineMemoryOpInterfaces.cpp.inc"
