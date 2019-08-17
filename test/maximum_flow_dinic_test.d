// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_A
// require: graph/maximum_flow_dinic.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto v = s[0];
    auto e = s[1];
    auto mf = new Dinic(v, 0, v-1);
    foreach (_; 0..e) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        auto cap = s[2];
        mf.add_edge(x, y, cap);
    }

    mf.run.writeln;
}
