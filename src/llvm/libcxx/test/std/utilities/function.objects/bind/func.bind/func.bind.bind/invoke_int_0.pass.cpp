//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03

// <functional>

// template<CopyConstructible Fn, CopyConstructible... Types>
//   unspecified bind(Fn, Types...);    // constexpr since C++20
// template<Returnable R, CopyConstructible Fn, CopyConstructible... Types>
//   unspecified bind(Fn, Types...);    // constexpr since C++20

#include <functional>
#include <cassert>

#include "test_macros.h"

template <class R, class F>
TEST_CONSTEXPR_CXX20
void test(F f, R expected) {
    assert(f() == expected);
}

template <class R, class F>
TEST_CONSTEXPR_CXX20
void test_const(const F& f, R expected) {
    assert(f() == expected);
}

TEST_CONSTEXPR_CXX20 int f() {return 1;}

struct A_int_0 {
    TEST_CONSTEXPR_CXX20 int operator()() {return 4;}
    TEST_CONSTEXPR_CXX20 int operator()() const {return 5;}
};

TEST_CONSTEXPR_CXX20 bool test_all() {
    test(std::bind(f), 1);
    test(std::bind(&f), 1);
    test(std::bind(A_int_0()), 4);
    test_const(std::bind(A_int_0()), 5);

    test(std::bind<int>(f), 1);
    test(std::bind<int>(&f), 1);
    test(std::bind<int>(A_int_0()), 4);
    test_const(std::bind<int>(A_int_0()), 5);
    return true;
}

int main(int, char**) {
    test_all();
#if TEST_STD_VER >= 20
    static_assert(test_all());
#endif

    return 0;
}
