// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_A
// require: data_structure/segment_tree.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = s[0];
    auto q = s[1];
    auto st = new SegmentTree!(int, min, (1<<31)-1)(n);

    while (q--) {
        s = readln.split.map!(to!int);
        auto t = s[0];
        auto x = s[1];
        auto y = s[2];
        if (t == 0) {
            st.assign(x, y);
        } else {
            st.query(x, y).writeln;
        }
    }
}
