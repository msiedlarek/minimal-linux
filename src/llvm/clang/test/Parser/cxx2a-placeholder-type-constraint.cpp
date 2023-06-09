// RUN: %clang_cc1 -std=c++2a -x c++ %s -verify

template<typename T, typename U=void>
concept C = true;

namespace ns {
  template<typename T, typename U=void>
  concept D = true;
}

int foo() {
  int I;
  {ns::D auto a = 1;}
  {C auto a = 1;}
  {C<> auto a = 1;}
  {C<int> auto a = 1;}
  {ns::D<int> auto a = 1;}
  {const ns::D auto &a = 1;}
  {const C auto &a = 1;}
  {const C<> auto &a = 1;}
  {const C<int> auto &a = 1;}
  {const ns::D<int> auto &a = 1;}
  {C decltype(auto) a = 1;}
  {C<> decltype(auto) a = 1;}
  {C<int> decltype(auto) a = 1;}
  {const C<> decltype(auto) &a = 1;} // expected-error{{'decltype(auto)' cannot be combined with other type specifiers}}
  // expected-error@-1{{cannot form reference to 'decltype(auto)'}}
  {const C<int> decltype(auto) &a = 1;} // expected-error{{'decltype(auto)' cannot be combined with other type specifiers}}
  // expected-error@-1{{cannot form reference to 'decltype(auto)'}}
  {C a = 1;}
  // expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
  {C const a2 = 1;}
  // expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
  {C &a3 = I;}
  // expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
  {C &&a4 = 1;}
  // expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
  {C decltype a19 = 1;}
  // expected-error@-1{{expected '('}}
  {C decltype(1) a20 = 1;}
  // expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
}

void foo1(C auto &a){}
void foo2(C const &a){}
// expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}
void foo3(C auto const &a){}
void foo4(const C &a){}
// expected-error@-1{{expected 'auto' or 'decltype(auto)' after concept name}}

namespace non_type {
  template<int v>
  concept C1 = true;

  auto f() -> C1 auto {} // expected-error{{concept named in type constraint is not a type concept}}
  auto g(C1 auto); // expected-error{{concept named in type constraint is not a type concept}}
  C1 auto a = 0; // expected-error{{concept named in type constraint is not a type concept}}
  C1 decltype(auto) b = 0; // expected-error{{concept named in type constraint is not a type concept}}
}

namespace arity {
  template<typename v, typename>
  concept C1 = true;

  auto f() -> C1 auto {} // expected-error{{'C1' requires more than 1 template argument; provide the remaining arguments explicitly to use it here}}
  auto g(C1 auto); // expected-error{{'C1' requires more than 1 template argument; provide the remaining arguments explicitly to use it here}}
  C1 auto a = 0; // expected-error{{'C1' requires more than 1 template argument; provide the remaining arguments explicitly to use it here}}
  C1 decltype(auto) b = 0; // expected-error{{'C1' requires more than 1 template argument; provide the remaining arguments explicitly to use it here}}
}
