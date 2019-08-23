// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=NTL_1_B
// require: number/modint.d

// Test for pow

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable uint mod = 10^^9 + 7;
alias mint = ModInt!mod;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = mint(s[0]);
    auto m = s[1];
    writeln(n^^m);
}
