// RUN: %clang_cc1 -verify -fopenmp-version=51 -fopenmp -DOMP51 -o - %s -Wuninitialized

// RUN: %clang_cc1 -verify -fopenmp-version=51 -fopenmp-simd -DOMP51 -o - %s -Wuninitialized

// RUN: %clang_cc1 -verify -fopenmp-version=50 -fopenmp -o - %s -Wuninitialized

// RUN: %clang_cc1 -verify -fopenmp-version=50 -fopenmp-simd -o - %s -Wuninitialized

void foo();

namespace {
static int y = 0;
}
static int x = 0;

int main(int argc, char **argv) {
  #pragma omp target
  #pragma omp teams default // expected-error {{expected '(' after 'default'}}
  foo();
  #pragma omp target
#pragma omp teams default( // expected-error {{expected 'none', 'shared', 'private' or 'firstprivate' in OpenMP clause 'default'}} expected-error {{expected ')'}} expected-note {{to match this '('}}
  foo();
  #pragma omp target
#pragma omp teams default() // expected-error {{expected 'none', 'shared', 'private' or 'firstprivate' in OpenMP clause 'default'}}
  foo();
  #pragma omp target
  #pragma omp teams default (none // expected-error {{expected ')'}} expected-note {{to match this '('}}
  foo();
  #pragma omp target
  #pragma omp teams default (shared), default(shared) // expected-error {{directive '#pragma omp teams' cannot contain more than one 'default' clause}}
  foo();
  #pragma omp target
#pragma omp teams default(x) // expected-error {{expected 'none', 'shared', 'private' or 'firstprivate' in OpenMP clause 'default'}}
  foo();

  #pragma omp target
  #pragma omp teams default(none) // expected-note {{explicit data sharing attribute requested here}}
  ++argc; // expected-error {{variable 'argc' must have explicitly specified data sharing attributes}}

  #pragma omp target
  #pragma omp teams default(none) // expected-note {{explicit data sharing attribute requested here}}
  #pragma omp parallel default(shared)
  ++argc; // expected-error {{variable 'argc' must have explicitly specified data sharing attributes}}

  #pragma omp teams if(x) // expected-error {{unexpected OpenMP clause 'if' in directive '#pragma omp teams'}}
  foo();

#ifdef OMP51
#pragma omp target
#pragma omp teams default(firstprivate) // expected-note 2 {{explicit data sharing attribute requested here}}
  {
    ++x; // expected-error {{variable 'x' must have explicitly specified data sharing attributes}}
    ++y; // expected-error {{variable 'y' must have explicitly specified data sharing attributes}}
  }
#pragma omp target
#pragma omp teams default(private) // expected-note 2 {{explicit data sharing attribute requested here}}
  {
    ++x; // expected-error {{variable 'x' must have explicitly specified data sharing attributes}}
    ++y; // expected-error {{variable 'y' must have explicitly specified data sharing attributes}}
  }
#pragma omp teams if(x) // expected-error {{unexpected OpenMP clause 'if' in directive '#pragma omp teams'}}
  foo();

#endif
  return 0;
}
