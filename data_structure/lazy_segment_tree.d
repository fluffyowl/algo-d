/*
  参考元: https://github.com/yosupo06/dunkelheit/blob/master/source/dkh/datastructure/segtree.d
*/

/*
  T: 取得クエリで取得する値の型
  L: 更新クエリで投げる値の型
  opTT: 2つの区間の結果をマージする関数 (T, T) -> T
  opTL: クエリを適用する（作用させる）関数 (T, L) -> T
  opLL: 2つのクエリをまとめる関数 (L, L) -> L
  opPrd: (L, int) -> 区間の長さに応じて結果を変化させる関数. 区間和とかに使う (L, int) -> T
  eT: Tの単位元
  eL: Lの単位元
 */

/*
  1. 区間代入 / 区間min
    auto st = new LazySegmentTree!(long, long, min, (a,b)=>b, (a,b)=>b, (a,b)=>a, 1L<<59, 1L<<59)(N);

  2. 区間加算 / 区間sum
    auto st = new LazySegmentTree!(long, long, (a,b)=>a+b, (a,b)=>a+b, (a,b)=>a+b, (a,b)=>a*b, 0L, 0L)(N+1);

  3. 区間加算 / 区間min
    auto st = new LazySegmentTree!(long, long, min, (a,b)=>a+b, (a,b)=>a+b, (a,b)=>a, 1L<<59, 0L)(N+1);
    st.table[] = 0L;

  4. 区間代入 / 区間sum
    auto st = new LazySegmentTree!(long, long, (a,b)=>a+b, (a,b)=>b, (a,b)=>b, (a,b)=>a*b, 0L, 1L<<59)(N+1);

  いずれもAOJでverify済.
  1. http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_F
  2. http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_G
  3. http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_H
  4. http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_I
 */

class LazySegmentTree(T, L, alias opTT, alias opTL, alias opLL, alias opPrd, T eT, L eL) {
    T[] table;
    L[] lazy_;
    int n;
    int size;

    this(int n) {
        this.n = n;
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 1;
        table = new T[](size);
        lazy_ = new L[](size);
        table[] = eT;
        lazy_[] = eL;
    }

    void push(int i, int a, int b) {
        if (lazy_[i] == eL) return;
        table[i] = opTL(table[i], opPrd(lazy_[i], b - a + 1));
        if (i * 2 + 1 < size) {
            lazy_[i*2] = opLL(lazy_[i*2], lazy_[i]);
            lazy_[i*2+1] = opLL(lazy_[i*2+1], lazy_[i]);
        }
        lazy_[i] = eL;
    }

    T query(int l, int r) {
        if (l > r) return eT;
        return query(l, r, 1, 0, n-1);
    }

    T query(int l, int r, int i, int a, int b) {
        if (b < l || r < a) return eT;
        push(i, a, b);
        if (l <= a && b <= r) {
            return table[i];
        } else {
            return opTT(query(l, r, i*2, a, (a+b)/2), query(l, r, i*2+1, (a+b)/2+1, b));
        }
    }

    void update(int l, int r, L val) {
        if (l > r) return;
        update(l, r, 1, 0, n-1, val);
    }

    void update(int l, int r, int i, int a, int b, L val) {
        if (b < l || r < a) {
            push(i, a, b);
        } else if (l <= a && b <= r) {
            lazy_[i] = opLL(lazy_[i], val);
            push(i, a, b);
        } else {
            push(i, a, b);
            update(l, r, i*2, a, (a+b)/2, val);
            update(l, r, i*2+1, (a+b)/2+1, b, val);
            table[i] = opTT(table[i*2], table[i*2+1]);
        }
    }
}
