struct Edge(T) {
    int to;
    T cost;
}

T[] dijkstra(T, T inf)(const Edge!(T)[][] graph, int start) {
    import std.typecons : Tuple, tuple;
    import std.conv : to;
    import std.container : BinaryHeap;

    int n = graph.length.to!int;
    auto dist = new T[](n);
    dist[] = inf;
    dist[start] = 0;

    auto pq = new BinaryHeap!(Array!(Edge!(T)), "a.cost > b.cost");
    pq.insert(Edge!(T)(start, 0));

    while (!pq.empty) {
        auto u = pq.front.to;
        auto cost = pq.front.cost;
        pq.removeFront;
        foreach (const e; graph[u]) {
            auto v = e.to;
            auto next_cost = cost + e.cost;
            if (dist[v] <= next_cost) continue;
            dist[v] = next_cost;
            pq.insert(Edge!(T)(v, next_cost));
        }
    }

    return dist;
}
