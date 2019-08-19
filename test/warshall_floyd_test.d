// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C
// require: graph/warshall_floyd.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long inf = 1L << 59;

    auto s = readln.split.map!(to!int);
    auto v = s[0];
    auto e = s[1];

    auto g = new long[][](v, v);
    foreach (i; 0..v) g[i][] = inf;
    foreach (i; 0..v) g[i][i] = 0;

    foreach (_; 0..e) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        auto cost = s[2];
        g[x][y] = cost;
    }

    auto dist = warshall_floyd!(long, inf)(g);

    if (v.iota.map!(i => dist[i][i] < 0).any) {
        writeln("NEGATIVE CYCLE");
    } else {
        dist.each!(a => a.map!(b => b == inf ? "INF" : to!string(b)).join(" ").writeln);
    }
}
