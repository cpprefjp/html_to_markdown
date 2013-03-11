```cpp
namespace std {
  template<class T> struct atomic;

  template<> struct atomic<<i>integral</i>>;
  template<class T> struct atomic<T*>;
}
```

##概要

<code>atomic</code>クラスは、型<code>T</code>をアトミック操作するためのクラスである。整数型およびポインタに対する特殊化が提供されており、それぞれに特化した演算が用意されている。その他の型に<code>atomic</code>クラスを使用する場合、型<code>T</code>はtrivially copyable (TODO)である必要がある。特殊化された整数型および<code>bool</code>型にはそれぞれ<code>atomic_T</code>という名前の<code>typedef</code>が提供される。

| | |
|--------------------------------|--------------------------------------------|
| 名前付きアトミック型 | テンプレート引数となる整数型 |
|<code> atomic_char</code> |<code> char</code> |
|<code> atomic_schar</code> |<code> signed char</code> |
|<code> atomic_uchar</code> |<code> unsigned char</code> |
|<code> atomic_short</code> |<code> short</code> |
|<code> atomic_ushort</code> |<code> unsigned short</code> |
|<code> atomic_int</code> |<code> int</code> |
|<code> atomic_long</code> |<code> long</code> |
|<code> atomic_ulong</code> |<code> unsigned long</code> |
|<code> atomic_llong</code> |<code> long long</code> |
|<code> atomic_ullong</code> |<code> unsigned long long</code> |
|<code> atomic_char16_t</code> |<code> char16_t</code> |
|<code> atomic_char32_t</code> |<code> char32_t</code> |
|<code> atomic_wchar_t</code> |<code> wchar_t</code> |
|<code> atomic_bool</code> |<code> bool</code> |
また、<inttypes.h>で定義される整数型に対する以下の<code>typedef</code>も提供される。
| | |
|------------------------------------|--------------------------------------------|
| 名前付きアトミック型 | テンプレート引数となる整数型 |
|<code> atomic_int_least8_t</code> |<code> int_least8_t</code> |
|<code> atomic_uint_least8_t</code> |<code> uint_least8_t</code> |
|<code> atomic_int_least16_t</code> |<code> int_least16_t</code> |
|<code> atomic_uint_least16_t</code> |<code> uint_least16_t</code> |
|<code> atomic_int_least32_t</code> |<code> int_least32_t</code> |
|<code> atomic_uint_least32_t</code> |<code> uint_least32_t</code> |
|<code> atomic_int_least64_t</code> |<code> int_least64_t</code> |
|<code> atomic_uint_least64_t</code> |<code> uint_least64_t</code> |
|<code> atomic_int_fast8_t</code> |<code> int_fast8_t</code> |
|<code> atomic_uint_fast8_t</code> |<code> uint_fast8_t</code> |
|<code> atomic_int_fast16_t</code> |<code> int_fast16_t</code> |
|<code> atomic_uint_fast16_t</code> |<code> uint_fast16_t</code> |
|<code> atomic_int_fast32_t</code> |<code> int_fast32_t</code> |
|<code> atomic_uint_fast32_t</code> |<code> uint_fast32_t</code> |
|<code> atomic_int_fast64_t</code> |<code> int_fast64_t</code> |
|<code> atomic_uint_fast64_t</code> |<code> uint_fast64_t</code> |
|<code> atomic_intptr_t</code> |<code> intptr_t</code> |
|<code> atomic_uintptr_t</code> |<code> uintptr_t</code> |
|<code> atomic_size_t</code> |<code> size_t</code> |
|<code> atomic_ptrdiff_t</code> |<code> ptrdiff_t</code> |
|<code> atomic_intmax_t</code> |<code> intmax_t</code> |
|<code> atomic_uintmax_t</code> |<code> uintmax_t</code> |
<code>void*</code>に対する特殊化の<code>typedef</code>として、<code>atomic_address</code>型が提供される。

###共通メンバ関数

| | |
|-------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| <code>[(constructor)](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/atomic)</code> | コンストラクタ |
| <code>~atomic() = default</code> | デストラクタ |
| <code>[operator=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_assign)</code> | 代入演算子 |
| <code>[is_lock_free](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/is_lock_free)</code> | オブジェクトがロックフリーに振る舞えるかを判定する |
| <code>[store](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/store)</code> | 値を書き込む |
| <code>[load](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/load)</code> | 値を読み込む |
| <code>[operator T](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_t)</code> | 型Tへの変換演算子 |
| <code>[exchange](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/exchange)</code> | 値を入れ替える |
| <code>[compare_exchange_weak](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/compare_exchange_weak)</code> | 弱い比較で値を入れ替える |
| <code>[compare_exchange_strong](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/compare_exchange_strong)</code> | 強い比較で値を入れ替える |

###atomic<integral>専用メンバ関数

| | |
|----------------------------------------------------------------------------------------------------------------------|-----------------------|
| <code>[fetch_add](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_add)</code> | 加算 |
| <code>[fetch_sub](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_sub)</code> | 減算 |
| <code>[fetch_and](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_and)</code> | AND演算 |
| <code>[fetch_or](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_or)</code> | OR演算 |
| <code>[fetch_xor](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_xor)</code> | XOR演算 |
| <code>[operator++](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_increment)</code> | インクリメント |
| <code>[operator--](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_decrement)</code> | デクリメント |
| <code>[operator+=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_plus_assign)</code> | 加算 |
| <code>[operator-=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_minus_assign)</code> | 減算 |
| <code>[operator&=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_and_assign)</code> | AND演算 |
| <code>[operator|=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_or_assign)</code> | OR演算 |
| <code>[operator^=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_xor_assign)</code> | XOR演算 |

###atomic<T*>専用メンバ関数

| | |
|----------------------------------------------------------------------------------------------------------------------|-----------------------|
| <code>[fetch_add](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_add)</code> | 加算 |
| <code>[fetch_sub](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_sub)</code> | 減算 |
| <code>[operator++](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_increment)</code> | インクリメント |
| <code>[operator--](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_decrement)</code> | デクリメント |
| <code>[operator+=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_plus_assign)</code> | 加算 |
| <code>[operator-=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_minus_assign)</code> | 減算 |

###例

```cpp
// スピンロックの実装
// Boost Atomic Library - Usage Example
// [http://www.boost.org/doc/libs/1_53_0/doc/html/atomic/usage_examples.html#boost_atomic.usage_examples.example_spinlock](http://www.boost.org/doc/libs/1_53_0/doc/html/atomic/usage_examples.html#boost_atomic.usage_examples.example_spinlock)

#include <iostream>
#include <atomic>
#include <thread>
#include <mutex>
 
class spinlock {
private:
  typedef enum {Locked, Unlocked} LockState;
  std::atomic<LockState> state_;

public:
  spinlock() : state_(Unlocked) {}
  
  void lock()
  {
    // 現在の状態をLockedと入れ替える
    while (state_.<color=000000>exchange</color>(Locked, std::memory_order_acquire) == Locked) {
      // busy-wait...アンロックされるまで待機
    }
  }

  void unlock()
  {
    // 値をUnlockedに更新
    state_.<color=000000>store</color>(Unlocked, std::memory_order_release);
  }
};

namespace {
  spinlock lock;
}

template <class T>
void print(const T& x)
{
  std::lock_guard<spinlock> lk(lock);
  std::cout << x << std::endl;
}

void f()
{
  print(1);
}

void g()
{
  print(2);
}

int main()
{
  std::thread t1(f);
  std::thread t2(g);

  t1.join();
  t2.join();
}
```
###出力例
```cpp
21
```
##バージョン

###言語

- C++11

###処理系

- [Clang](https://sites.google.com/site/cpprefjp/implementation#clang): ??
- [GCC](https://sites.google.com/site/cpprefjp/implementation#gcc): 
- [GCC, C++0x mode](https://sites.google.com/site/cpprefjp/implementation#gcc): 4.7.0(atomic_addressは未実装)
- [ICC](https://sites.google.com/site/cpprefjp/implementation#icc): ??
- [Visual C++](https://sites.google.com/site/cpprefjp/implementation#visual_cpp) ??


###参照
[N2145 C++ Atomic Types and Operations](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2007/n2145.html)
[アトミックオブジェクトを含むクラスのコピーとムーブ - Faith and Brave - C++で遊ぼう](http://d.hatena.ne.jp/faith_and_brave/20130110/1357808183)

