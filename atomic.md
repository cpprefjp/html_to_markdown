<table style='width:877px' cellspacing='0'><tbody><tr><td><div dir='ltr'><div/>```cpp
<code>namespace std {</code>
<code>  </code>template<class T> struct atomic;

  template<> struct atomic<<i>integral</i>>;
  template<class T> struct atomic<T*>;
<code>}</code>
```##概要<p><code>atomic</code>クラスは、型<code>T</code>をアトミック操作するためのクラスである。整数型およびポインタに対する特殊化が提供されており、それぞれに特化した演算が用意されている。その他の型に<code>atomic</code>クラスを使用する場合、型<code>T</code>はtrivially copyable (TODO)である必要がある。特殊化された整数型および<code>bool</code>型にはそれぞれ<code>atomic_T</code>という名前の<code>typedef</code>が提供される。</p><table style='border-collapse:collapse;border-color:rgb(136,136,136);border-width:1px' cellspacing='0' bordercolor='#888' border='1'><tbody><tr><td style='width:142px;height:15px'> 名前付きアトミック型</td><td style='width:195px;height:15px'> テンプレート引数となる整数型</td></tr><tr><td style='width:142px;height:15px'><code> atomic_char</code></td><td style='width:195px;height:15px'><code> char</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_schar</code></td><td style='width:195px;height:15px'><code> signed char</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_uchar</code></td><td style='width:195px;height:15px'><code> unsigned char</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_short</code></td><td style='width:195px;height:15px'><code> short</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_ushort</code></td><td style='width:195px;height:15px'><code> unsigned short</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_int</code></td><td style='width:195px;height:15px'><code> int</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_long</code></td><td style='width:195px;height:15px'><code> long</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_ulong</code></td><td style='width:195px;height:15px'><code> unsigned long</code></td></tr><tr><td style='width:142px;height:15px'><code> atomic_llong</code></td><td style='width:195px;height:15px'><code> long long</code></td></tr><tr><td><code> atomic_ullong</code></td><td><code> unsigned long long</code></td></tr><tr><td><code> atomic_char16_t</code></td><td><code> char16_t</code></td></tr><tr><td><code> atomic_char32_t</code></td><td><code> char32_t</code></td></tr><tr><td><code> atomic_wchar_t</code></td><td><code> wchar_t</code></td></tr><tr><td><code> atomic_bool</code></td><td><code> bool</code></td></tr></tbody></table>また、<inttypes.h>で定義される整数型に対する以下の<code>typedef</code>も提供される。<table style='border-collapse:collapse;border-color:rgb(136,136,136);border-width:1px' cellspacing='0' bordercolor='#888' border='1'><tbody><tr><td style='width:162px;height:15px'> 名前付きアトミック型</td><td style='width:188px;height:15px'> テンプレート引数となる整数型</td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_least8_t</code></td><td style='width:188px;height:12px'><code> int_least8_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_least8_t</code></td><td style='width:188px;height:12px'><code> uint_least8_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_least16_t</code></td><td style='width:188px;height:12px'><code> int_least16_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_least16_t</code></td><td style='width:188px;height:12px'><code> uint_least16_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_least32_t</code></td><td style='width:188px;height:12px'><code> int_least32_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_least32_t</code></td><td style='width:188px;height:12px'><code> uint_least32_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_least64_t</code></td><td style='width:188px;height:12px'><code> int_least64_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_least64_t</code></td><td style='width:188px;height:12px'><code> uint_least64_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_fast8_t</code></td><td style='width:188px;height:12px'><code> int_fast8_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_fast8_t</code></td><td style='width:188px;height:12px'><code> uint_fast8_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_fast16_t</code></td><td style='width:188px;height:12px'><code> int_fast16_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_fast16_t</code></td><td style='width:188px;height:12px'><code> uint_fast16_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_fast32_t</code></td><td style='width:188px;height:12px'><code> int_fast32_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_fast32_t</code></td><td style='width:188px;height:12px'><code> uint_fast32_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_int_fast64_t</code></td><td style='width:188px;height:12px'><code> int_fast64_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uint_fast64_t</code></td><td style='width:188px;height:12px'><code> uint_fast64_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_intptr_t</code></td><td style='width:188px;height:12px'><code> intptr_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uintptr_t</code></td><td style='width:188px;height:12px'><code> uintptr_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_size_t</code></td><td style='width:188px;height:12px'><code> size_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_ptrdiff_t</code></td><td style='width:188px;height:12px'><code> ptrdiff_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_intmax_t</code></td><td style='width:188px;height:12px'><code> intmax_t</code></td></tr><tr><td style='width:162px;height:12px'><code> atomic_uintmax_t</code></td><td style='width:188px;height:12px'><code> uintmax_t</code></td></tr></tbody></table><code>void*</code>に対する特殊化の<code>typedef</code>として、<code>atomic_address</code>型が提供される。######共通メンバ関数<table style='border-collapse:collapse;border-color:rgb(136,136,136);border-width:1px' cellspacing='0' bordercolor='#888' border='1'><tbody><tr><td style='width:184px;height:15px'> <code>[(constructor)](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/atomic)</code></td><td style='width:296px;height:15px'> コンストラクタ</td></tr><tr><td style='width:184px;height:15px'> <code>~atomic() = default</code></td><td style='width:296px;height:15px'> デストラクタ</td></tr><tr><td style='width:184px;height:15px'> <code>[operator=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_assign)</code></td><td style='width:296px;height:15px'> 代入演算子</td></tr><tr><td style='width:184px;height:15px'> <code>[is_lock_free](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/is_lock_free)</code></td><td style='width:296px;height:15px'> オブジェクトがロックフリーに振る舞えるかを判定する</td></tr><tr><td style='width:184px;height:15px'> <code>[store](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/store)</code></td><td style='width:296px;height:15px'> 値を書き込む</td></tr><tr><td style='width:184px;height:15px'> <code>[load](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/load)</code></td><td style='width:296px;height:15px'> 値を読み込む</td></tr><tr><td style='width:184px;height:15px'> <code>[operator T](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_t)</code></td><td style='width:296px;height:15px'> 型Tへの変換演算子</td></tr><tr><td style='width:184px;height:15px'> <code>[exchange](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/exchange)</code></td><td style='width:296px;height:15px'> 値を入れ替える</td></tr><tr><td style='width:184px;height:15px'> <code>[compare_exchange_weak](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/compare_exchange_weak)</code></td><td style='width:296px;height:15px'> 弱い比較で値を入れ替える</td></tr><tr><td style='width:184px;height:15px'> <code>[compare_exchange_strong](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/compare_exchange_strong)</code></td><td style='width:296px;height:15px'> 強い比較で値を入れ替える</td></tr></tbody></table>###atomic<integral>専用メンバ関数<table style='border-collapse:collapse;border-top-color:rgb(136,136,136);border-right-color:rgb(136,136,136);border-bottom-color:rgb(136,136,136);border-left-color:rgb(136,136,136);border-top-width:1px;border-right-width:1px;border-bottom-width:1px;border-left-width:1px' cellspacing='0' bordercolor='#888' border='1'><tbody><tr><td style='width:112px;height:15px'> <code>[fetch_add](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_add)</code></td><td style='width:286px;height:15px'> 加算</td></tr><tr><td style='width:112px;height:15px'> <code>[fetch_sub](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_sub)</code></td><td style='width:286px;height:15px'> 減算</td></tr><tr><td style='width:112px;height:15px'> <code>[fetch_and](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_and)</code></td><td style='width:286px;height:15px'> AND演算</td></tr><tr><td style='width:112px;height:15px'> <code>[fetch_or](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_or)</code></td><td style='width:286px;height:15px'> OR演算</td></tr><tr><td style='width:112px;height:15px'> <code>[fetch_xor](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_xor)</code></td><td style='width:286px;height:15px'> XOR演算</td></tr><tr><td> <code>[operator++](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_increment)</code></td><td> インクリメント</td></tr><tr><td> <code>[operator--](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_decrement)</code></td><td> デクリメント</td></tr><tr><td> <code>[operator+=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_plus_assign)</code></td><td> 加算</td></tr><tr><td> <code>[operator-=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_minus_assign)</code></td><td> 減算</td></tr><tr><td> <code>[operator&=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_and_assign)</code></td><td> AND演算</td></tr><tr><td> <code>[operator|=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_or_assign)</code></td><td> OR演算</td></tr><tr><td> <code>[operator^=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_xor_assign)</code></td><td> XOR演算</td></tr></tbody></table>###atomic<T*>専用メンバ関数<table style='border-collapse:collapse;border-top-color:rgb(136,136,136);border-right-color:rgb(136,136,136);border-bottom-color:rgb(136,136,136);border-left-color:rgb(136,136,136);border-top-width:1px;border-right-width:1px;border-bottom-width:1px;border-left-width:1px' cellspacing='0' bordercolor='#888' border='1'><tbody><tr><td style='width:113px;height:15px'> <code>[fetch_add](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_add)</code></td><td style='width:283px;height:15px'> 加算</td></tr><tr><td style='width:113px;height:15px'> <code>[fetch_sub](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/fetch_sub)</code></td><td style='width:283px;height:15px'> 減算</td></tr><tr><td style='width:113px;height:15px'> <code>[operator++](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_increment)</code></td><td style='width:283px;height:15px'> インクリメント</td></tr><tr><td style='width:113px;height:15px'> <code>[operator--](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_decrement)</code></td><td style='width:283px;height:15px'> デクリメント</td></tr><tr><td> <code>[operator+=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_plus_assign)</code></td><td> 加算</td></tr><tr><td> <code>[operator-=](https://sites.google.com/site/cpprefjp/reference/atomic/atomic/op_minus_assign)</code></td><td> 減算</td></tr></tbody></table>###例
<div/>```cpp
// スピンロックの実装
// Boost Atomic Library - Usage Example
// <a rel='nofollow' href='http://www.boost.org/doc/libs/1_53_0/doc/html/atomic/usage_examples.html#boost_atomic.usage_examples.example_spinlock'>http://www.boost.org/doc/libs/1_53_0/doc/html/atomic/usage_examples.html#boost_atomic.usage_examples.example_spinlock</a>

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
<span style='color:rgb(0,0,0)'>    state_.</span><color=000000>store</color>(Unlocked, std::memory_order_release);
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
###出力例```cpp
21
##<div style='font-size:13px;font-weight:normal'><h2>バージョン###言語
- C++11
###処理系
- [Clang](https://sites.google.com/site/cpprefjp/implementation#clang): ??
- [GCC](https://sites.google.com/site/cpprefjp/implementation#gcc): 
- [GCC, C++0x mode](https://sites.google.com/site/cpprefjp/implementation#gcc): 4.7.0(atomic_addressは未実装)
- [ICC](https://sites.google.com/site/cpprefjp/implementation#icc): ??
- [Visual C++](https://sites.google.com/site/cpprefjp/implementation#visual_cpp) ??
```
<h3 style='font-size:13px;font-weight:normal'>参照</h3><div style='font-size:13px;font-weight:normal'><a rel='nofollow' href='http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2007/n2145.html'>N2145 C++ Atomic Types and Operations</a>
<font size='2'><span style='font-weight:normal'><a rel='nofollow' href='http://d.hatena.ne.jp/faith_and_brave/20130110/1357808183'>アトミックオブジェクトを含むクラスのコピーとムーブ - Faith and Brave - C++で遊ぼう</a></span>

</h2>