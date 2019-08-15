class MinCostFlow {
    alias Tuple!(int, "to", int, "cap", int, "cost", int, "rev") Edge;
    immutable int INF = 1 << 29;

    int V;
    Edge[][] G;
    int[] h;
    int[] dist;
    int[] prevv;
    int[] preve;

    this(int v) {
        V = v;
        G = new Edge[][](v);
        h = new int[](v);
        dist = new int[](v);
        prevv = new int[](v);
        preve = new int[](v);
    }

    void add_edge(int from, int to, int cap, int cost) {
        G[from] ~= Edge(to, cap, cost, G[to].length.to!int);
        G[to] ~= Edge(from, 0, -cost, G[from].length.to!int - 1);
    }

    int run(int s, int t, int f) { // source, sink, flow
        int res = 0;
        h.fill(0);
        while (f > 0) {
            auto pq = new BinaryHeap!(Array!(Tuple!(int, int)), "a[0] < b[0]");
            dist.fill(INF);
            dist[s] = 0;
            pq.insert(tuple(0, s));
            while (!pq.empty) {
                auto p = pq.front;
                pq.removeFront;
                int v = p[1];
                if (dist[v] < p[0]) continue;
                foreach (i; 0..G[v].length.to!int) {
                    auto e = G[v][i];
                    if (e.cap > 0 && dist[e.to] > dist[v] + e.cost + h[v] - h[e.to]) {
                        dist[e.to] = dist[v] + e.cost + h[v] - h[e.to];
                        prevv[e.to] = v;
                        preve[e.to] = i;
                        pq.insert(tuple(dist[e.to], e.to));
                    }
                }
            }
            if (dist[t] == INF) {
                return -1;
            }
            foreach (v; 0..V) {
                h[v] += dist[v];
            }

            int d = f;
            for (int v = t; v != s; v = prevv[v]) {
                d = min(d, G[prevv[v]][preve[v]].cap);
            }
            f -= d;
            res += d * h[t];
            for (int v = t; v != s; v = prevv[v]) {
                G[prevv[v]][preve[v]].cap -= d;
                G[v][G[prevv[v]][preve[v]].rev].cap += d;
            }
        }

        return res;
    }
}
