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
    auto dk = new DirectedDijkstra!(long, 1L<<59)(v);
    foreach (_; 0..e) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        auto cost = s[2];
        dk.add_edge(x, y, cost);
    }

    auto dist = dk.run(r);
    v.iota.map!(i => dist[i] == 1L<<59 ? "INF" : to!string(dist[i])).each!writeln;
}
