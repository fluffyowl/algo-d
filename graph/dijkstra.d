struct Edge(T) {
    int to;
    T cost;
}

class DirectedDijkstra(T, T inf) {
    import std.typecons : Tuple, tuple;
    import std.conv : to;
    import std.container : BinaryHeap;

    int n;
    Edge!(T)[][] adj;
    T[] dist;

    this(int n) {
        this.n = n;
        adj = new Edge!(T)[][](n);
        dist = new T[](n);
    }

    void add_edge(int from, int to, T cost) {
        adj[from] ~= Edge!(T)(to, cost);
    }

    T[] run(int start) {
        dist[] = inf;
        dist[start] = 0;

        auto pq = new BinaryHeap!(Array!(Edge!(T)), "a.cost > b.cost");
        pq.insert(Edge!(T)(start, to!T(0)));

        while (!pq.empty) {
            auto u = pq.front.to;
            auto cost = pq.front.cost;
            pq.removeFront;
            foreach (const e; adj[u]) {
                auto v = e.to;
                auto next_cost = cost + e.cost;
                if (dist[v] <= next_cost) continue;
                dist[v] = next_cost;
                pq.insert(Edge!(T)(v, next_cost));
            }
        }
        return dist;
    }
}
