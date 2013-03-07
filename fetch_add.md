```cpp
T fetch_add(T operand, [memory_order](https://sites.google.com/site/cpprefjp/reference/atomic/memory_order) order = [memory_order_seq_cst](https://sites.google.com/site/cpprefjp/reference/atomic/memory_order)) volatile noexcept;
T fetch_add(T operand, [memory_order](https://sites.google.com/site/cpprefjp/reference/atomic/memory_order) order = [memory_order_seq_cst](https://sites.google.com/site/cpprefjp/reference/atomic/memory_order)) noexcept;
```
##概要
<b>加算を行う</b>

##効果
<code>order</code>で指定されたメモリオーダーにしたがって、現在の値に<code>operandを加算した値</code>でアトミックに置き換える


##戻り値
変更前の値が返される


##例外
投げない

##備考
この関数は、<code>atomic</code>クラスの整数型およびポインタに対する特殊化で定義される。

符号付き整数型に対しては、2の補数表現による演算が行われ、未定義動作はない。アドレス型に関しては結果として未定義アドレスになる場合があるが、それ以外の未定義動作はない。

##例
```cpp
#include <iostream>
#include <atomic>

int main()
{
  std::atomic<int> x(3);

  int before = x.<color=000000>fetch_add</color>(2);

  std::cout << before << std::endl;
  std::cout << x.load() << std::endl;
}
```
###出力
```cpp
3
5
```
##バージョン
###言語

- C++11


###処理系
- [Clang](https://sites.google.com/site/cpprefjp/implementation#clang): ??
- [GCC](https://sites.google.com/site/cpprefjp/implementation#gcc): 
- [GCC, C++0x mode](https://sites.google.com/site/cpprefjp/implementation#gcc): 4.7.0
- [ICC](https://sites.google.com/site/cpprefjp/implementation#icc): ??
- [Visual C++](https://sites.google.com/site/cpprefjp/implementation#visual_cpp) ??


##参照

