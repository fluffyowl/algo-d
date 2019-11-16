// require: number/modint.d

// manually verified on: https://atcoder.jp/contests/exawizards2019/tasks/exawizards2019_e
// manually verified on: https://yukicoder.me/problems/no/117

class Combinations(uint mod) {
    alias mint = ModInt!mod;
    mint[] f;

    this(int maxval) {
        f = new mint[](maxval);
        f[0] = f[1] = mint(1);
        foreach(i; 1..maxval-1) {
            f[i+1] = f[i] * (i+1);
        }
    }

    mint nCr(int n, int r) {
        if (n < r) return mint(0);
        return f[n] / f[n-r] / f[r];
    }

    mint nPr(int n, int r) {
        if (n < r) return mint(0);
        return f[n] / f[n-r];
    }

    mint nHr(int n, int r) {
        if (n == 0 &&r == 0) return mint(1);
        if (n == 0) return mint(0);
        return f[n+r-1] / f[n-1] / f[r];
    }
}
