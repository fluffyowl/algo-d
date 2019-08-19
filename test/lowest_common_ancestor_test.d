// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C
// require: graph/lowest_common_ancestor.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto n = readln.chomp.to!int;
    auto g = new int[][](n);
    foreach (i; 0..n) {
        auto s = readln.split.map!(to!int).array;
        auto k = s.front;
        foreach (j; 1..k+1) {
            g[i] ~= s[j];
            g[s[j]] ~= i;
        }
    }

    auto lca = new LowestCommonAncestor(g, 0);

    auto q = readln.chomp.to!int;
    while (q--) {
        auto s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        writeln(lca.lca(x, y));
    }
}
