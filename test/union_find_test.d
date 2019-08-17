// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_1_A
// require: data_structure/union_find.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = s[0];
    auto q = s[1];
    auto uf = new UnionFind(n);

    while (q--) {
        s = readln.split.map!(to!int);
        auto t = s[0];
        auto u = s[1];
        auto v = s[2];
        if (s[0] == 0) {
            uf.unite(u ,v);
        } else {
            writeln(uf.same(u, v) ? 1 : 0);
        }
    }
}
