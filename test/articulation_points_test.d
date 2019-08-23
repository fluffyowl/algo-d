// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_A
// require: graph/articulation_points.d

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

    auto articulation_points = detect_articulation_points(g);
    articulation_points.sort();
    articulation_points.each!writeln;
}
