class Dinic {
    import std.typecons : Tuple;
    import std.conv : to;
    import std.container : DList;
    import std.algorithm : min;

    alias Edge = Tuple!(int, "to", long, "cap", long, "rev");
    immutable long INF = 1L << 59;

    int V, source, sink;
    Edge[][] G;
    int[] itr, level;

    this(int V, int s, int t) {
        this.V = V;
        G = new Edge[][](V);
        source = s;
        sink = t;
    }

    void add_edge(int from, int to, long cap) {
        G[from] ~= Edge(to, cap, G[to].length.to!long);
        G[to] ~= Edge(from, 0, G[from].length.to!long-1);
    }

    void bfs(int s) {
        level = new int[](V);
        level[] = -1;
        DList!int q;
        level[s] = 0;
        q.insertBack(s);
        while (!q.empty) {
            int v = q.front();
            q.removeFront();
            foreach (e; G[v]){
                if (e.cap > 0 && level[e.to] < 0) {
                    level[e.to] = level[v] + 1;
                    q.insertBack(e.to);
                }
            }
        }
    }

    long dfs(int v, int t, long f) {
        if (v == t) return f;
        for (int i = itr[v]; i < G[v].length.to!int; ++i) {
            if (G[v][i].cap > 0 && level[v] < level[G[v][i].to]) {
                long d = dfs(G[v][i].to, t, min(f, G[v][i].cap));
                if (d > 0) {
                    G[v][i].cap -= d;
                    G[G[v][i].to][G[v][i].rev].cap += d;
                    return d;
                }
            }
        }
        return 0;
    }

    long run() {
        long ret = 0, f;
        while (true) {
            bfs(source);
            if (level[sink] < 0) break;
            itr = new int[](V);
            while ((f = dfs(source, sink, INF)) > 0) ret += f;
        }
        return ret;
    }
}
