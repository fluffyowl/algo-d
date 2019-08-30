// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B
// require: string/kmp_search.d


import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    auto T = readln.chomp;
    kmp_search(S, T).each!writeln;
}
