// problem: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_2_H
// require: data_structure/lazy_segment_tree.d

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto st = new LazySegmentTree!(long, long, min, (a,b)=>a+b, (a,b)=>a+b, (a,b)=>a, 1L<<59, 0L)(N+1);
    st.table[] = 0L;

    while (Q--) {
        s = readln.split.map!(to!int);
        int q = s[0];
        int l = s[1];
        int r = s[2];
        if (q == 0) {
            long v = s[3];
            st.update(l, r, v);
        } else {
            st.query(l, r).writeln;
        }
    }
}
