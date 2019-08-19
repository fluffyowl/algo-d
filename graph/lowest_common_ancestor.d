// This is O(log(n)) implementation with doubling.

class LowestCommonAncestor {
    import std.algorithm : swap;
    import std.conv : to;
    import std.typecons : Tuple, tuple;
    import core.bitop : bsr;

    int n, root, lgn;
    int[][] graph;
    int[] depth;
    int[][] dp;

    this(const int[][] graph, int root) {
        n = graph.length.to!int;
        this.root = root;
        this.graph = new int[][](n);
        foreach (i; 0..n) this.graph[i] = graph[i].dup;

        lgn = bsr(n) + 3;
        depth = new int[](n);
        dp = new int[][](n, lgn);

        construct;
    }

    int lca(int a, int b) {
        if (depth[a] < depth[b]) swap(a, b);

        int diff = depth[a] - depth[b];
        foreach_reverse (i; 0..lgn) if (diff & (1<<i)) a = dp[a][i];

        if (a == b) return a;

        int K = lgn;
        while (dp[a][0] != dp[b][0]) {
            foreach_reverse (k; 0..lgn) {
                if (dp[a][k] != dp[b][k]) {
                    a = dp[a][k];
                    b = dp[b][k];
                    K = k;
                }
            }
        }

        return dp[a][0];
    }

    private void construct() {
        auto stack = new Tuple!(int, int, int)[](n+10);
        int sp = 0;
        stack[0] = tuple(root, -1, 0);
        while (sp >= 0) {
            auto u = stack[sp][0];
            auto p = stack[sp][1];
            auto d = stack[sp][2];
            sp -= 1;
            dp[u][0] = p;
            depth[u] = d;
            foreach (v; graph[u]) if (v != p) stack[++sp] = tuple(v, u, d+1);
        }

        foreach (k; 0..lgn-1)
            foreach (i; 0..n)
                dp[i][k+1] = (dp[i][k] == -1) ? -1 : dp[dp[i][k]][k];
    }
}
