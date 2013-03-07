    namespace std {
      template <class InputIterator, class Distance>
      void advance(InputIterator& i, Distance n);
    }
##概要
<b>イテレータをn回進める。</b>

##要件
双方向イテレータもしくはランダムアクセスイテレータの場合のみ、nが負数であることを許可する。

##効果
イテレータへの参照iをn回進める(nが負数の場合は逆方向に進める)。

##戻り値
なし

##計算量
規格上の規定はないが、多くの実装では以下のようになっている。

入力イテレータ、前方向イテレータ ： n回のインクリメント
双方向イテレータ： n回のインクリメント、もしくはデクリメント
ランダムアクセスイテレータ： O(1)

##例
    #include <iostream>
    #include <iterator>
    #include <vector>
    
    int main()
    {
      std::vector<int> v = {3, 1, 4, 2, 5};
    
      decltype(v)::iterator i = v.begin();
      std::<color=000000>advance</color>(i, 3); // イテレータiを3回進める
    
      std::cout << *i << std::endl;
    }
###出力
    2
##実装例
    // 入力イテレータ(or 前方向イテレータ)
    template <class InputIterator, class Distance>
    void advance_impl(InputIterator& i, Distance n, std::input_iterator_tag)
    {
      assert(n >= 0);
    
      for (; 0 < n; --n) { ++i; }
    }
    
    // 双方向イテレータ
    template <class BidirectionalIterator, class Distance>
    void advance_impl(BidirectionalIterator& i, Distance n, std::bidirectional_iterator_tag)
    {
      if (n > 0) {
        for (; 0 < n; --n) { ++i; }
      }
      else {
        for (; n < 0; ++n) { --i; }
      }
    }
    
    // ランダムアクセスイテレータ
    template <class RandomAccessIterator, class Distance>
    void advance_impl(RandomAccessIterator& i, Distance n, std::random_access_iterator_tag)
    {
      i += n;
    }
    
    template <class Iterator, class Distance>
    void advance(Iterator& i, Distance n)
    {
      advance_impl(i, n,
              typename std::iterator_traits<Iterator>::iterator_category());
              // イテレータのカテゴリごとに最適な実装を選択させる
    }
##参照
