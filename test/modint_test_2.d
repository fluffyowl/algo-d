// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=0341
// require: number/modint.d

// Test for plus

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable uint mod = 10^^9 + 7;
alias mint = ModInt!mod;

void main() {
    auto s = readln.chomp;
    auto t = readln.chomp;
    auto n = s.length.to!int;
    auto m = t.length.to!int;
    auto dp = new mint[][](n+1, m+1);
    dp[0][0] = mint(1);

    foreach (i; 0..n) {
        dp[i+1] = dp[i].dup;
        foreach (j; 0..m) {
            if (s[i] == t[j]) {
                dp[i+1][j+1] += dp[i][j];
            }
        }
    }

    dp[n][m].writeln;
}
