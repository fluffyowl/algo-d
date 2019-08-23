// require: graph/dfs_tree.d

import std.algorithm : filter;
import std.conv : to;
import std.range : array, iota;
import std.typecons : Tuple, tuple;

int[] detect_articulation_points(const int[][] graph) {
    int n = graph.length.to!int;
    auto dfs_tree = new DfsTree(graph);
    return n.iota.filter!(i => dfs_tree.is_articulation_point(i)).array;
}
