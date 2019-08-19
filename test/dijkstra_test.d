// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
// require: graph/dijkstra.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto v = s[0];
    auto e = s[1];
    auto r = s[2];
    auto g = new Edge!(long)[][](v);
    foreach (_; 0..e) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        auto cost = s[2];
        g[x] ~= Edge!(long)(y, cost);
    }

    auto dist = dijkstra!(long, 1L<<59)(g, r);
    v.iota.map!(i => dist[i] == 1L<<59 ? "INF" : to!string(dist[i])).each!writeln;
}
