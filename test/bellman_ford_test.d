// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B
// require: graph/bellman_ford.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 50;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = s[0];
    auto m = s[1];
    auto start = s[2];
    auto g = new Edge!long[][](n);
    foreach (_; 0..m) {
        s = readln.split.map!(to!int);
        auto u = s[0];
        auto v = s[1];
        long c = s[2];
        g[u] ~= Edge!long(v, c);
    }

    auto dist = bellman_ford!(long, INF)(g, start);

    if (dist.map!(d => d == -INF).any) {
        writeln("NEGATIVE CYCLE");
    } else {
        dist.map!(d => d == INF ? "INF" : to!string(d)).each!writeln;
    }
}
