//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <new>

// void* operator new[](std::size_t);

// UNSUPPORTED: c++03, c++11, c++14, c++17

// REQUIRES: -faligned-allocation
// ADDITIONAL_COMPILE_FLAGS: -faligned-allocation

#include <new>

void f() {
    ::operator new[](4);  // expected-warning {{ignoring return value of function declared with 'nodiscard' attribute}}
}
