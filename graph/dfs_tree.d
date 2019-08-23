// This assumes the input graph as undirected and connected.

class DfsTree {
    import std.algorithm : any, map, min, swap;
    import std.conv : to;
    import std.typecons : Tuple, tuple;

    int n;
    int[] ord;
    int[] low;
    int[] parent;
    int[][] graph;

    this(const int[][] graph, int root = 0) {
        n = graph.length.to!int;
        ord = new int[](n);
        low = new int[](n);
        parent = new int[](n);
        this.graph = new int[][](n);
        construct_dfs_tree(graph, root);
    }

    public bool is_bridge(int u, int v) {
        if (u != parent[v] && v != parent[u]) {
            return false;
        }
        if (v == parent[u]) {
            swap(u, v);
        }
        return ord[u] < low[v];
    }

    public bool is_articulation_point(int u) {
        if (ord[u] == 0) {
            return graph[u].length >= 2;
        } else {
            foreach (v; graph[u]) {
                if (parent[u] == v) continue;
                if (ord[u] <= low[v]) return true;
            }
            return false;
        }
    }

    private void construct_dfs_tree(const int[][] org, int root) {
        int cnt = 0;
        ord[] = -1;
        low[] = -1;

        void dfs(int n, int p) {
            ord[n] = low[n] = cnt++;
            foreach (m; org[n]) {
                if (m == p) continue;
                if (ord[m] == -1) {
                    parent[m] = n;
                    graph[n] ~= m;
                    graph[m] ~= n;
                    dfs(m, n);
                    low[n] = min(low[n], low[m]);
                } else {
                    low[n] = min(low[n], ord[m]);
                }
            }
        }

        dfs(root, -1);
    }
}
