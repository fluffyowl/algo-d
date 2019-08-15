class PersistentUnionFind {
    import std.algorithm;
    import std.range;
    import std.conv;

    int[][] rank;
    int[][] time;
    int[][] parent;
    int n;
    int global_time;

    this(int n) {
        this.n = n;
        rank = new int[][](n);
        time = new int[][](n);
        parent = new int[][](n);
        foreach (i; 0..n) {
            rank[i] ~= 1;
            time[i] ~= 0;
            parent[i] ~= i;
        }
        global_time = 0;
    }

    void unite(int u, int v) {
        global_time += 1;
        u = find(u, global_time);
        v = find(v, global_time);
        if (u == v) return;

        if (rank[u] < rank[v]) swap(u, v);

        int r = rank[u].back + rank[v].back;

        rank[u] ~= r;
        time[u] ~= global_time;
        parent[u] ~= u;

        rank[v] ~= r;
        time[v] ~= global_time;
        parent[v] ~= u;
    }

    int find(int u, int t) {
        if (parent[u].back == u) return u;
        if (time[u].back > t) return u;
        return find(parent[u].back, t);
    }

    int size(int u, int t) {
        int v = find(u, t);
        int i = time[v].assumeSorted.lowerBound(t+1).length.to!int;
        return rank[v][i-1];
    }
}
