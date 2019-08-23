// require: graph/dfs_tree.d

import std.conv : to;
import std.typecons : Tuple, tuple;

Tuple!(int, int)[] detect_bridges(const int[][] graph) {
    int n = graph.length.to!int;
    Tuple!(int, int)[] bridges;
    auto dfs_tree = new DfsTree(graph);

    foreach (u; 0..n) {
        foreach (v; graph[u]) {
            if (v == dfs_tree.parent[u]) continue;
            if (dfs_tree.is_bridge(u, v)) bridges ~= tuple(u, v.to!int);
        }
    }

    return bridges;
}
