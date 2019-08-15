class FordFulkerson(T) {
    int N, source, sink;
    int[][] adj;
    T[][] flow;
    bool[] used;

    this(int n, int s, int t) {
        N = n;
        source = s;
        sink = t;
        assert (s >= 0 && s < N && t >= 0 && t < N);
        adj = new int[][](N);
        flow = new T[][](N, N);
        used = new bool[](N);
    }

    void add_edge(int from, int to, T cap) {
        adj[from] ~= to;
        adj[to] ~= from;
        flow[from][to] = cap;
    }

    T dfs(int v, T min_cap) {
        if (v == sink)
            return min_cap;
        if (used[v])
            return 0;
        used[v] = true;
        foreach (to; adj[v]) {
            if (!used[to] && flow[v][to] > 0) {
                auto bottleneck = dfs(to, min(min_cap, flow[v][to]));
                if (bottleneck == 0) continue;
                flow[v][to] -= bottleneck;
                flow[to][v] += bottleneck;
                return bottleneck;
            }
        }
        return 0;
    }

    T run() {
        T ret = 0;
        while (true) {
            foreach (i; 0..N) used[i] = false;
            T f = dfs(source, T.max);
            if (f > 0)
                ret += f;
            else
                return ret;
        }
    }
}
