// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_B
// require: graph/bridges.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = s[0];
    auto m = s[1];
    auto g = new int[][](n);
    foreach (_; 0..m) {
        s = readln.split.map!(to!int);
        g[s[0]]  ~= s[1];
        g[s[1]]  ~= s[0];
    }

    auto bridges = detect_bridges(g);
    foreach (i; 0..bridges.length.to!int) {
        if (bridges[i][0] > bridges[i][1]) {
            swap(bridges[i][0], bridges[i][1]);
        }
    }
    bridges.sort!"a < b";

    bridges.each!(t => writeln(t[0], " ", t[1]));
}
