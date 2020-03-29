// This implementation of ModInt references https://github.com/yosupo06/dunkelheit/blob/master/source/dkh/modint.d

// Manually verified on: https://yukicoder.me/problems/no/117
// Manually verified on: https://atcoder.jp/contests/cpsco2019-s3/tasks/cpsco2019_s3_f

struct ModInt(uint mod) {
    import std.conv : to;

    uint n;

    this(int n) {
        this.n = to!uint((n % mod.to!int + mod.to!int) % mod);
    }

    this(long n) {
        this.n = to!uint((n % mod.to!long + mod.to!long) % mod);
    }

    private this(uint n) {
        this.n = n;
    }

    string toString() const {
        return to!string(this.n);
    }

    private uint normilize(uint n) const {
        return n < mod ? n : n - mod;
    }

    private ModInt pow(uint n, long x) const {
        long ret = 1;
        long a = n;
        while (x) {
            if (x & 1) ret = ret * a % mod;
            a = a * a % mod;
            x >>= 1;
        }
        return ModInt(to!ulong(ret));
    }

    auto opBinary(string op : "+")(ModInt!mod rhs) const {
        return ModInt(normilize(n + rhs.n));
    }

    auto opBinary(string op : "-")(ModInt!mod rhs) const {
        return ModInt(normilize(n + mod - rhs.n));
    }

    auto opBinary(string op : "*")(ModInt!mod rhs) const {
        return ModInt(to!uint(to!long(n) * rhs.n % mod));
    }

    auto opBinary(string op : "/")(ModInt!mod rhs) const {
        return this * pow(rhs.n, mod-2);
    }

    auto opBinary(string op : "^^")(ModInt!mod rhs) const {
        return pow(this.n, rhs.n);
    }

    auto opBinary(string op, T)(T rhs) const {
        auto mod_rhs = ModInt!mod(rhs);
        return opBinary!op(mod_rhs);
    }

    auto opOpAssign(string op)(ModInt!mod rhs) {
        return mixin ("this=this"~op~"rhs");
    }

    auto opEquals(ModInt!mod rhs) const {
        return this.n == rhs.n;
    }

    auto opEquals(T)(T rhs) const {
        return this == ModInt!mod(rhs);
    }
}
