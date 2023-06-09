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

#include <stdio.h>

#include <functional>
#include <cassert>

#include "test_macros.h"

int count = 0;

// 1 arg, return void

void f_void_1(int i)
{
    count += i;
}

struct A_void_1
{
    void operator()(int i)
    {
        count += i;
    }

    void mem1() {++count;}
    void mem2() const {count += 2;}
};

void
test_void_1()
{
    using namespace std::placeholders;
    int save_count = count;
    // function
    {
    int i = 2;
    std::bind(f_void_1, _1)(i);
    assert(count == save_count + 2);
    save_count = count;
    }
    {
    int i = 2;
    std::bind(f_void_1, i)();
    assert(count == save_count + 2);
    save_count = count;
    }
    // function pointer
    {
    void (*fp)(int) = f_void_1;
    int i = 3;
    std::bind(fp, _1)(i);
    assert(count == save_count+3);
    save_count = count;
    }
    {
    void (*fp)(int) = f_void_1;
    int i = 3;
    std::bind(fp, i)();
    assert(count == save_count+3);
    save_count = count;
    }
    // functor
    {
    A_void_1 a0;
    int i = 4;
    std::bind(a0, _1)(i);
    assert(count == save_count+4);
    save_count = count;
    }
    {
    A_void_1 a0;
    int i = 4;
    std::bind(a0, i)();
    assert(count == save_count+4);
    save_count = count;
    }
    // member function pointer
    {
    void (A_void_1::*fp)() = &A_void_1::mem1;
    A_void_1 a;
    std::bind(fp, _1)(a);
    assert(count == save_count+1);
    save_count = count;
    A_void_1* ap = &a;
    std::bind(fp, _1)(ap);
    assert(count == save_count+1);
    save_count = count;
    }
    {
    void (A_void_1::*fp)() = &A_void_1::mem1;
    A_void_1 a;
    std::bind(fp, a)();
    assert(count == save_count+1);
    save_count = count;
    A_void_1* ap = &a;
    std::bind(fp, ap)();
    assert(count == save_count+1);
    save_count = count;
    }
    // const member function pointer
    {
    void (A_void_1::*fp)() const = &A_void_1::mem2;
    A_void_1 a;
    std::bind(fp, _1)(a);
    assert(count == save_count+2);
    save_count = count;
    A_void_1* ap = &a;
    std::bind(fp, _1)(ap);
    assert(count == save_count+2);
    save_count = count;
    }
    {
    void (A_void_1::*fp)() const = &A_void_1::mem2;
    A_void_1 a;
    std::bind(fp, a)();
    assert(count == save_count+2);
    save_count = count;
    A_void_1* ap = &a;
    std::bind(fp, ap)();
    assert(count == save_count+2);
    save_count = count;
    }
}

// 1 arg, return int

TEST_CONSTEXPR_CXX20 int f_int_1(int i) {
    return i + 1;
}

struct A_int_1 {
    TEST_CONSTEXPR_CXX20 A_int_1() : data_(5) {}
    TEST_CONSTEXPR_CXX20 int operator()(int i) {
        return i - 1;
    }

    TEST_CONSTEXPR_CXX20 int mem1() { return 3; }
    TEST_CONSTEXPR_CXX20 int mem2() const { return 4; }
    int data_;
};

TEST_CONSTEXPR_CXX20 bool test_int_1() {
    using namespace std::placeholders;
    // function
    {
    int i = 2;
    assert(std::bind(f_int_1, _1)(i) == 3);
    assert(std::bind(f_int_1, i)() == 3);
    }
    // function pointer
    {
    int (*fp)(int) = f_int_1;
    int i = 3;
    assert(std::bind(fp, _1)(i) == 4);
    assert(std::bind(fp, i)() == 4);
    }
    // functor
    {
    int i = 4;
    assert(std::bind(A_int_1(), _1)(i) == 3);
    assert(std::bind(A_int_1(), i)() == 3);
    }
    // member function pointer
    {
    A_int_1 a;
    assert(std::bind(&A_int_1::mem1, _1)(a) == 3);
    assert(std::bind(&A_int_1::mem1, a)() == 3);
    A_int_1* ap = &a;
    assert(std::bind(&A_int_1::mem1, _1)(ap) == 3);
    assert(std::bind(&A_int_1::mem1, ap)() == 3);
    }
    // const member function pointer
    {
    A_int_1 a;
    assert(std::bind(&A_int_1::mem2, _1)(A_int_1()) == 4);
    assert(std::bind(&A_int_1::mem2, A_int_1())() == 4);
    A_int_1* ap = &a;
    assert(std::bind(&A_int_1::mem2, _1)(ap) == 4);
    assert(std::bind(&A_int_1::mem2, ap)() == 4);
    }
    // member data pointer
    {
    A_int_1 a;
    assert(std::bind(&A_int_1::data_, _1)(a) == 5);
    assert(std::bind(&A_int_1::data_, a)() == 5);
    A_int_1* ap = &a;
    assert(std::bind(&A_int_1::data_, _1)(a) == 5);
    std::bind(&A_int_1::data_, _1)(a) = 6;
    assert(std::bind(&A_int_1::data_, _1)(a) == 6);
    assert(std::bind(&A_int_1::data_, _1)(ap) == 6);
    std::bind(&A_int_1::data_, _1)(ap) = 7;
    assert(std::bind(&A_int_1::data_, _1)(ap) == 7);
    }

    return true;
}

// 2 arg, return void

void f_void_2(int i, int j)
{
    count += i+j;
}

struct A_void_2
{
    void operator()(int i, int j)
    {
        count += i+j;
    }

    void mem1(int i) {count += i;}
    void mem2(int i) const {count += i;}
};

void
test_void_2()
{
    using namespace std::placeholders;
    int save_count = count;
    // function
    {
    int i = 2;
    int j = 3;
    std::bind(f_void_2, _1, _2)(i, j);
    assert(count == save_count+5);
    save_count = count;
    std::bind(f_void_2, i, _1)(j);
    assert(count == save_count+5);
    save_count = count;
    std::bind(f_void_2, i, j)();
    assert(count == save_count+5);
    save_count = count;
    }
    // member function pointer
    {
    int j = 3;
    std::bind(&A_void_2::mem1, _1, _2)(A_void_2(), j);
    assert(count == save_count+3);
    save_count = count;
    std::bind(&A_void_2::mem1, _2, _1)(j, A_void_2());
    assert(count == save_count+3);
    save_count = count;
    }
}

struct ConstQualifiedMemberFunction {
    TEST_CONSTEXPR_CXX20 bool foo(unsigned long long) const {
        return true;
    }
};

TEST_CONSTEXPR_CXX20 bool test_const_qualified_member() {
    using namespace std;
    using namespace std::placeholders;
    const auto f = bind(&ConstQualifiedMemberFunction::foo, _1, 0UL);
    const ConstQualifiedMemberFunction n = ConstQualifiedMemberFunction{};
    bool b = f(n);
    assert(b);
    return true;
}

TEST_CONSTEXPR_CXX20 bool test_many_args() {
    using namespace std::placeholders;
    auto f = [](int& a, char&, float&, long&) -> int& { return a; };
    auto bound = std::bind(f, _4, _3, _2, _1);
    int a = 3; char b = '2'; float c = 1.0f; long d = 0l;
    int& result = bound(d, c, b, a);
    assert(&result == &a);
    return true;
}

int main(int, char**) {
    test_void_1();
    test_int_1();
    test_void_2();
    test_const_qualified_member();
    test_many_args();

    // The other tests are not constexpr-friendly since they need to use a global variable
#if TEST_STD_VER >= 20
    static_assert(test_int_1());
    static_assert(test_const_qualified_member());
    static_assert(test_many_args());
#endif

    return 0;
}
